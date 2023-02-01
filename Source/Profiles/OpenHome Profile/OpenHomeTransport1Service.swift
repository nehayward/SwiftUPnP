import Foundation
import Combine
import XMLCoder
import os.log

public class OpenHomeTransport1Service: UPnPService {
	struct Envelope<T: Codable>: Codable {
		enum CodingKeys: String, CodingKey {
			case body = "s:Body"
		}

		var body: T
	}

	public enum TransportStateEnum: String, Codable {
		case playing = "Playing"
		case paused = "Paused"
		case stopped = "Stopped"
		case buffering = "Buffering"
		case waiting = "Waiting"
	}

	public func playAs(mode: String, command: String, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case mode = "Mode"
				case command = "Command"
			}

			@Attribute var urn: String
			public var mode: String
			public var command: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:PlayAs"
			}

			var action: SoapAction
		}
		try await post(action: "PlayAs", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), mode: mode, command: command))), log: log)
	}

	public func play(log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Play"
			}

			var action: SoapAction
		}
		try await post(action: "Play", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)
	}

	public func pause(log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Pause"
			}

			var action: SoapAction
		}
		try await post(action: "Pause", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)
	}

	public func stop(log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Stop"
			}

			var action: SoapAction
		}
		try await post(action: "Stop", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)
	}

	public func skipNext(log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SkipNext"
			}

			var action: SoapAction
		}
		try await post(action: "SkipNext", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)
	}

	public func skipPrevious(log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SkipPrevious"
			}

			var action: SoapAction
		}
		try await post(action: "SkipPrevious", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)
	}

	public func setRepeat(`repeat`: Bool, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case `repeat` = "Repeat"
			}

			@Attribute var urn: String
			public var `repeat`: Bool
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetRepeat"
			}

			var action: SoapAction
		}
		try await post(action: "SetRepeat", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), `repeat`: `repeat`))), log: log)
	}

	public func setShuffle(shuffle: Bool, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case shuffle = "Shuffle"
			}

			@Attribute var urn: String
			public var shuffle: Bool
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SetShuffle"
			}

			var action: SoapAction
		}
		try await post(action: "SetShuffle", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), shuffle: shuffle))), log: log)
	}

	public func seekSecondAbsolute(streamId: UInt32, secondAbsolute: UInt32, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case streamId = "StreamId"
				case secondAbsolute = "SecondAbsolute"
			}

			@Attribute var urn: String
			public var streamId: UInt32
			public var secondAbsolute: UInt32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SeekSecondAbsolute"
			}

			var action: SoapAction
		}
		try await post(action: "SeekSecondAbsolute", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), streamId: streamId, secondAbsolute: secondAbsolute))), log: log)
	}

	public func seekSecondRelative(streamId: UInt32, secondRelative: Int32, log: UPnPService.MessageLog = .none) async throws {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
				case streamId = "StreamId"
				case secondRelative = "SecondRelative"
			}

			@Attribute var urn: String
			public var streamId: UInt32
			public var secondRelative: Int32
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:SeekSecondRelative"
			}

			var action: SoapAction
		}
		try await post(action: "SeekSecondRelative", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType), streamId: streamId, secondRelative: secondRelative))), log: log)
	}

	public struct TransportStateResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case state = "State"
		}

		public var state: TransportStateEnum

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))TransportStateResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))state: \(state.rawValue)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func transportState(log: UPnPService.MessageLog = .none) async throws -> TransportStateResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:TransportState"
				case response = "u:TransportStateResponse"
			}

			var action: SoapAction?
			var response: TransportStateResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "TransportState", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct ModesResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case modes = "Modes"
		}

		public var modes: String

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))ModesResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))modes: '\(modes)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func modes(log: UPnPService.MessageLog = .none) async throws -> ModesResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Modes"
				case response = "u:ModesResponse"
			}

			var action: SoapAction?
			var response: ModesResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "Modes", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct ModeInfoResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case canSkipNext = "CanSkipNext"
			case canSkipPrevious = "CanSkipPrevious"
			case canRepeat = "CanRepeat"
			case canShuffle = "CanShuffle"
		}

		public var canSkipNext: Bool
		public var canSkipPrevious: Bool
		public var canRepeat: Bool
		public var canShuffle: Bool

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))ModeInfoResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))canSkipNext: \(canSkipNext == true ? "true" : "false")")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))canSkipPrevious: \(canSkipPrevious == true ? "true" : "false")")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))canRepeat: \(canRepeat == true ? "true" : "false")")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))canShuffle: \(canShuffle == true ? "true" : "false")")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func modeInfo(log: UPnPService.MessageLog = .none) async throws -> ModeInfoResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:ModeInfo"
				case response = "u:ModeInfoResponse"
			}

			var action: SoapAction?
			var response: ModeInfoResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "ModeInfo", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct StreamInfoResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case streamId = "StreamId"
			case canSeek = "CanSeek"
			case canPause = "CanPause"
		}

		public var streamId: UInt32
		public var canSeek: Bool
		public var canPause: Bool

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))StreamInfoResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))streamId: \(streamId)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))canSeek: \(canSeek == true ? "true" : "false")")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))canPause: \(canPause == true ? "true" : "false")")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func streamInfo(log: UPnPService.MessageLog = .none) async throws -> StreamInfoResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:StreamInfo"
				case response = "u:StreamInfoResponse"
			}

			var action: SoapAction?
			var response: StreamInfoResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "StreamInfo", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct StreamIdResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case streamId = "StreamId"
		}

		public var streamId: UInt32

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))StreamIdResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))streamId: \(streamId)")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func streamId(log: UPnPService.MessageLog = .none) async throws -> StreamIdResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:StreamId"
				case response = "u:StreamIdResponse"
			}

			var action: SoapAction?
			var response: StreamIdResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "StreamId", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct RepeatResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case `repeat` = "Repeat"
		}

		public var `repeat`: Bool

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))RepeatResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))`repeat`: \(`repeat` == true ? "true" : "false")")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func `repeat`(log: UPnPService.MessageLog = .none) async throws -> RepeatResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Repeat"
				case response = "u:RepeatResponse"
			}

			var action: SoapAction?
			var response: RepeatResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "Repeat", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

	public struct ShuffleResponse: Codable {
		enum CodingKeys: String, CodingKey {
			case shuffle = "Shuffle"
		}

		public var shuffle: Bool

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))ShuffleResponse {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))shuffle: \(shuffle == true ? "true" : "false")")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
	}
	public func shuffle(log: UPnPService.MessageLog = .none) async throws -> ShuffleResponse {
		struct SoapAction: Codable {
			enum CodingKeys: String, CodingKey {
				case urn = "xmlns:u"
			}

			@Attribute var urn: String
		}
		struct Body: Codable {
			enum CodingKeys: String, CodingKey {
				case action = "u:Shuffle"
				case response = "u:ShuffleResponse"
			}

			var action: SoapAction?
			var response: ShuffleResponse?
		}
		let result: Envelope<Body> = try await postWithResult(action: "Shuffle", envelope: Envelope(body: Body(action: SoapAction(urn: Attribute(serviceType)))), log: log)

		guard let response = result.body.response else { throw ServiceParseError.noValidResponse }
		return response
	}

}

// Event parser
extension OpenHomeTransport1Service {
	public struct State: Codable {
		enum CodingKeys: String, CodingKey {
			case modes = "Modes"
			case canSkipNext = "CanSkipNext"
			case canSkipPrevious = "CanSkipPrevious"
			case canRepeat = "CanRepeat"
			case canShuffle = "CanShuffle"
			case streamId = "StreamId"
			case canSeek = "CanSeek"
			case canPause = "CanPause"
			case transportState = "TransportState"
			case `repeat` = "Repeat"
			case shuffle = "Shuffle"
		}

		public var modes: String?
		public var canSkipNext: Bool?
		public var canSkipPrevious: Bool?
		public var canRepeat: Bool?
		public var canShuffle: Bool?
		public var streamId: UInt32?
		public var canSeek: Bool?
		public var canPause: Bool?
		public var transportState: TransportStateEnum?
		public var `repeat`: Bool?
		public var shuffle: Bool?

		public func log(deep: Bool = false, indent: Int = 0) {
			Logger.swiftUPnP.debug("\(Logger.indent(indent))OpenHomeTransport1ServiceState {")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))modes: '\(modes ?? "nil")'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))canSkipNext: \((canSkipNext == nil) ? "nil" : (canSkipNext! == true ? "true" : "false"))")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))canSkipPrevious: \((canSkipPrevious == nil) ? "nil" : (canSkipPrevious! == true ? "true" : "false"))")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))canRepeat: \((canRepeat == nil) ? "nil" : (canRepeat! == true ? "true" : "false"))")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))canShuffle: \((canShuffle == nil) ? "nil" : (canShuffle! == true ? "true" : "false"))")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))streamId: \(streamId ?? 0)'")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))canSeek: \((canSeek == nil) ? "nil" : (canSeek! == true ? "true" : "false"))")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))canPause: \((canPause == nil) ? "nil" : (canPause! == true ? "true" : "false"))")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))transportState: \(transportState?.rawValue ?? "nil")")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))`repeat`: \((`repeat` == nil) ? "nil" : (`repeat`! == true ? "true" : "false"))")
			Logger.swiftUPnP.debug("\(Logger.indent(indent+1))shuffle: \((shuffle == nil) ? "nil" : (shuffle! == true ? "true" : "false"))")
			Logger.swiftUPnP.debug("\(Logger.indent(indent))}")
		}
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
			if let modes = property.modes {
				result.modes = modes
			}
			if let canSkipNext = property.canSkipNext {
				result.canSkipNext = canSkipNext
			}
			if let canSkipPrevious = property.canSkipPrevious {
				result.canSkipPrevious = canSkipPrevious
			}
			if let canRepeat = property.canRepeat {
				result.canRepeat = canRepeat
			}
			if let canShuffle = property.canShuffle {
				result.canShuffle = canShuffle
			}
			if let streamId = property.streamId {
				result.streamId = streamId
			}
			if let canSeek = property.canSeek {
				result.canSeek = canSeek
			}
			if let canPause = property.canPause {
				result.canPause = canPause
			}
			if let transportState = property.transportState {
				result.transportState = transportState
			}
			if let `repeat` = property.`repeat` {
				result.`repeat` = `repeat`
			}
			if let shuffle = property.shuffle {
				result.shuffle = shuffle
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
