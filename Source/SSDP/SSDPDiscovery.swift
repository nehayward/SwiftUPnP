//
//  SSDPDiscovery.swift
//  
//
//  Created by Berrie Kremers on 31/12/2022.
//

import Foundation
import Network
import Combine
import os.log

public enum UPnPError: Error {
    case alreadyConnected
    case networkingError(String)
}

public class SSDPDiscovery {
    enum SSDPMessageType {
        case searchResponse
        case availableNotification
        case updateNotification
        case unavailableNotification
    }
    
    private let multicastGroupAddress = "239.255.255.250"
    private let multicastUDPPort: UInt16 = 1900
    private var multicastGroup: NWMulticastGroup?
    private var connectionGroup: NWConnectionGroup?
    private var types = [String]()
    
    func startDiscovery(forTypes types: [String]) throws {
        guard multicastGroup == nil else { throw UPnPError.alreadyConnected }
        let multicastGroup = try NWMulticastGroup(for:[.hostPort(host: .init(multicastGroupAddress), port: .init(integerLiteral: multicastUDPPort))])
        let connectionGroup = NWConnectionGroup(with: multicastGroup, using: .udp)
        
        connectionGroup.stateUpdateHandler = { (newState) in
            Logger.swiftUPnP.debug("Connection group entered state \(String(describing: newState))")
            
            switch newState {
            case let .failed(error):
                Logger.swiftUPnP.error("\(error.localizedDescription)")
                break
            default:
                break
            }
        }
        connectionGroup.setReceiveHandler(maximumMessageSize: 65535, rejectOversizedMessages: true) { (message, content, isComplete) in
            if let content = content {
                self.processData(content)
            }
        }
        
        connectionGroup.start(queue: .main)
        
        self.types = types
        self.multicastGroup = multicastGroup
        self.connectionGroup = connectionGroup
    }
    
    func stopDiscovery() {
        guard let connectionGroup = connectionGroup else { return }
        connectionGroup.cancel()
        multicastGroup = nil
        self.connectionGroup = nil
        types = []
    }
    
    func searchRequest() {
        guard let connectionGroup = connectionGroup else { return }

        for type in types {
            if let data = self.searchRequestData(forType: type) {
                connectionGroup.send(content: data) { error in
                    if let error = error as? NSError {
                        self.stopDiscovery()
                        Logger.swiftUPnP.error("\(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    private func searchRequestData(forType type: String) -> Data? {
        ["M-SEARCH * HTTP/1.1",
         "HOST: \(multicastGroupAddress):\(multicastUDPPort)",
         "MAN: \"ssdp:discover\"",
         "ST: \(type)",
         "MX: 3",
         "USER-AGENT: \(UserAgentGenerator().UAString)\r\n\r\n"].joined(separator: "\r\n").data(using: .utf8)
    }
    
    private func handleSSDPMessage(_ messageType: SSDPMessageType, headers: [String: String]) {
        if let usnRawValue = headers["usn"] {
            let usnComponents = usnRawValue.components(separatedBy: "::")
            if usnComponents.count == 2,
               let locationString = headers["location"],
               let locationURL = URL(string: locationString),
               /// NT = Notification Type - SSDP discovered from device advertisements
               /// ST = Search Target - SSDP discovered as a result of using M-SEARCH requests
                let ssdpType = (headers["st"] != nil ? headers["st"] : headers["nt"]) {
                
                let uuid = usnComponents[0]
                let deviceId = usnComponents[1]

                if types.contains(ssdpType) {
                    if messageType == .unavailableNotification {
                        Task {
                            await UPnPRegistry.shared.remove(UPnPDevice(uuid: uuid, deviceId: deviceId, deviceType: ssdpType, url: locationURL))
                        }
                    }
                    else {
                        Task {
                            await UPnPRegistry.shared.add(UPnPDevice(uuid: uuid, deviceId: deviceId, deviceType: ssdpType, url: locationURL))
                        }
                    }
                }
            }
        }
    }
    
    private func processData(_ data: Data) {
        if let message = String(data: data, encoding: .utf8) {
            var httpMethodLine: String?
            var headers = [String: String]()
            
            message.enumerateLines(invoking: { (line, stop) -> () in
                if httpMethodLine == nil {
                    httpMethodLine = line
                } else {
                    let parts = line.components(separatedBy: ": ")
                    if parts.count == 2 {
                        headers[String(parts[0].lowercased())] = String(parts[1])
                    }
                }
            })
            
            if let httpMethodLine = httpMethodLine {
                let nts = headers["nts"]
                switch (httpMethodLine, nts) {
                case ("HTTP/1.1 200 OK", _):
                    handleSSDPMessage(.searchResponse, headers: headers)
                case ("NOTIFY * HTTP/1.1", .some(let notificationType)) where notificationType == "ssdp:alive":
                    handleSSDPMessage(.availableNotification, headers: headers)
                case ("NOTIFY * HTTP/1.1", .some(let notificationType)) where notificationType == "ssdp:update":
                    handleSSDPMessage(.updateNotification, headers: headers)
                case ("NOTIFY * HTTP/1.1", .some(let notificationType)) where notificationType == "ssdp:byebye":
                    headers["location"] = headers["host"] // byebye messages don't have a location
                    handleSSDPMessage(.unavailableNotification, headers: headers)
                default:
                    return
                }
            }
        }
    }
}


