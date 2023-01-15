import Foundation
import Combine
import XMLCoder

public class OpenHomePins1Service: UPnPService {
	struct Envelope<T: Codable>: Codable {
		enum CodingKeys: String, CodingKey {
			case body = "s:Body"
		}

		var body: T
	}

	public struct GetDeviceMaxResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case deviceMax = "DeviceMax"
		}

		public var deviceMax: UInt32
	}
	public func getDeviceMax() async throws -> GetDeviceMaxResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetDeviceMax"
			}

			var action: SoapAction?
			var response: GetDeviceMaxResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetDeviceMax", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))))

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct GetAccountMaxResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case accountMax = "AccountMax"
		}

		public var accountMax: UInt32
	}
	public func getAccountMax() async throws -> GetAccountMaxResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetAccountMax"
			}

			var action: SoapAction?
			var response: GetAccountMaxResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetAccountMax", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))))

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct GetModesResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case modes = "Modes"
		}

		public var modes: String
	}
	public func getModes() async throws -> GetModesResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetModes"
			}

			var action: SoapAction?
			var response: GetModesResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetModes", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))))

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct GetIdArrayResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case idArray = "IdArray"
		}

		public var idArray: String
	}
	public func getIdArray() async throws -> GetIdArrayResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetIdArray"
			}

			var action: SoapAction?
			var response: GetIdArrayResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetIdArray", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))))

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct GetCloudConnectedResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case cloudConnected = "CloudConnected"
		}

		public var cloudConnected: Bool
	}
	public func getCloudConnected() async throws -> GetCloudConnectedResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:GetCloudConnected"
			}

			var action: SoapAction?
			var response: GetCloudConnectedResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "GetCloudConnected", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))))

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct ReadListResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case list = "List"
		}

		public var list: String
	}
	public func readList(ids: String) async throws -> ReadListResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case ids = "Ids"
			}

			@Attribute var urn: String
			public var ids: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:ReadList"
			}

			var action: SoapAction?
			var response: ReadListResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "ReadList", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), ids: ids))))

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public func invokeId(id: UInt32) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case id = "Id"
			}

			@Attribute var urn: String
			public var id: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:InvokeId"
			}

			var action: SoapAction
		}
		try await post(action: "InvokeId", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), id: id))))
	}

	public func invokeIndex(index: UInt32) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case index = "Index"
			}

			@Attribute var urn: String
			public var index: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:InvokeIndex"
			}

			var action: SoapAction
		}
		try await post(action: "InvokeIndex", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), index: index))))
	}

	public func invokeUri(mode: String, type: String, uri: String, shuffle: Bool) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case mode = "Mode"
				case type = "Type"
				case uri = "Uri"
				case shuffle = "Shuffle"
			}

			@Attribute var urn: String
			public var mode: String
			public var type: String
			public var uri: String
			public var shuffle: Bool
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:InvokeUri"
			}

			var action: SoapAction
		}
		try await post(action: "InvokeUri", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), mode: mode, type: type, uri: uri, shuffle: shuffle))))
	}

	public func setDevice(index: UInt32, mode: String, type: String, uri: String, title: String, description: String, artworkUri: String, shuffle: Bool) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case index = "Index"
				case mode = "Mode"
				case type = "Type"
				case uri = "Uri"
				case title = "Title"
				case description = "Description"
				case artworkUri = "ArtworkUri"
				case shuffle = "Shuffle"
			}

			@Attribute var urn: String
			public var index: UInt32
			public var mode: String
			public var type: String
			public var uri: String
			public var title: String
			public var description: String
			public var artworkUri: String
			public var shuffle: Bool
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetDevice"
			}

			var action: SoapAction
		}
		try await post(action: "SetDevice", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), index: index, mode: mode, type: type, uri: uri, title: title, description: description, artworkUri: artworkUri, shuffle: shuffle))))
	}

	public func setAccount(index: UInt32, mode: String, type: String, uri: String, title: String, description: String, artworkUri: String, shuffle: Bool) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case index = "Index"
				case mode = "Mode"
				case type = "Type"
				case uri = "Uri"
				case title = "Title"
				case description = "Description"
				case artworkUri = "ArtworkUri"
				case shuffle = "Shuffle"
			}

			@Attribute var urn: String
			public var index: UInt32
			public var mode: String
			public var type: String
			public var uri: String
			public var title: String
			public var description: String
			public var artworkUri: String
			public var shuffle: Bool
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetAccount"
			}

			var action: SoapAction
		}
		try await post(action: "SetAccount", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), index: index, mode: mode, type: type, uri: uri, title: title, description: description, artworkUri: artworkUri, shuffle: shuffle))))
	}

	public func clear(id: UInt32) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case id = "Id"
			}

			@Attribute var urn: String
			public var id: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Clear"
			}

			var action: SoapAction
		}
		try await post(action: "Clear", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), id: id))))
	}

	public func swap(index1: UInt32, index2: UInt32) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case index1 = "Index1"
				case index2 = "Index2"
			}

			@Attribute var urn: String
			public var index1: UInt32
			public var index2: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Swap"
			}

			var action: SoapAction
		}
		try await post(action: "Swap", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), index1: index1, index2: index2))))
	}

}

// Event parser
extension OpenHomePins1Service {
	public struct State: Codable {
		enum CodingKeys: String, CodingKey {
			case deviceMax = "DeviceMax"
			case accountMax = "AccountMax"
			case modes = "Modes"
			case idArray = "IdArray"
			case cloudConnected = "CloudConnected"
		}

		public var deviceMax: UInt32?
		public var accountMax: UInt32?
		public var modes: String?
		public var idArray: String?
		public var cloudConnected: Bool?
	}

	public func state(xml: Data) throws -> State {
		struct PropertySet: Codable {
			var property: [State]
		}

		let decoder = XMLDecoder()
		decoder.shouldProcessNamespaces = true
		let propertySet = try decoder.decode(PropertySet.self, from: xml)

		return propertySet.property.reduce(State()) { partialResult, property in
			var result = partialResult
			if let deviceMax = property.deviceMax {
				result.deviceMax = deviceMax
			}
			if let accountMax = property.accountMax {
				result.accountMax = accountMax
			}
			if let modes = property.modes {
				result.modes = modes
			}
			if let idArray = property.idArray {
				result.idArray = idArray
			}
			if let cloudConnected = property.cloudConnected {
				result.cloudConnected = cloudConnected
			}
			return result
		}
	}

	public var stateSubject: AnyPublisher<State, Never> {
		subscribedEventPublisher
			.compactMap { [weak self] in
				guard let self else { return nil }

				return try? self.state(xml: $0)
			}
			.eraseToAnyPublisher()
	}
}
