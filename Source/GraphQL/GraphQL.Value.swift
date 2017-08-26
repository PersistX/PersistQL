import Foundation

extension GraphQL {
    /// A value in a GraphQL document.
    enum Value {
        case variable(Variable)
        case int(Int)
        case float(Float)
        case string(String)
        case boolean(Bool)
        case null
        case `enum`(Name)
        case list([Value])
        case object([Name: Value])
    }
}

extension GraphQL.Value {
    init(_ constant: GraphQL.Constant) {
        switch constant {
        case let .int(int):
            self = .int(int)
        case let .float(float):
            self = .float(float)
        case let .string(string):
            self = .string(string)
        case let .boolean(boolean):
            self = .boolean(boolean)
        case .null:
            self = .null
        case let .enum(value):
            self = .enum(value)
        case let .list(list):
            self = .list(list.map(GraphQL.Value.init))
        case let .object(object):
            self = .object(object.mapValues(GraphQL.Value.init))
        }
    }
}

extension GraphQL.Value: Hashable {
    var hashValue: Int {
        switch self {
        case let .variable(variable):
            return variable.hashValue
        case let .int(int):
            return int.hashValue
        case let .float(float):
            return float.hashValue
        case let .string(string):
            return string.hashValue
        case let .boolean(boolean):
            return boolean.hashValue
        case .null:
            return 0
        case let .enum(`enum`):
            return `enum`.hashValue
        case let .list(list):
            return list.map { $0.hashValue }.reduce(0, ^)
        case let .object(object):
            return object.map { $0.key.hashValue ^ $0.value.hashValue }.reduce(0, ^)
        }
    }
    
    static func ==(lhs: GraphQL.Value, rhs: GraphQL.Value) -> Bool {
        switch (lhs, rhs) {
        case let (.variable(lhs), .variable(rhs)):
            return lhs == rhs
        case let (.int(lhs), .int(rhs)):
            return lhs == rhs
        case let (.float(lhs), .float(rhs)):
            return lhs == rhs
        case let (.string(lhs), .string(rhs)):
            return lhs == rhs
        case let (.boolean(lhs), .boolean(rhs)):
            return lhs == rhs
        case (.null, .null):
            return true
        case let (.enum(lhs), .enum(rhs)):
            return lhs == rhs
        case let (.list(lhs), .list(rhs)):
            return lhs == rhs
        case let (.object(lhs), .object(rhs)):
            return lhs == rhs
        default:
            return false
        }
    }
}

extension GraphQL.Value: CustomStringConvertible {
    var description: String {
        switch self {
        case let .variable(variable):
            return variable.description
        case let .int(int):
            return int.description
        case let .float(float):
            return float.description
        case let .string(string):
            let substituted = string
                .replacingOccurrences(of: "\u{005c}", with: "\\\\")
                .replacingOccurrences(of: "\u{0022}", with: "\\\"")
                .replacingOccurrences(of: "\u{002f}", with: "\\/")
                .replacingOccurrences(of: "\u{0008}", with: "\\b")
                .replacingOccurrences(of: "\u{000c}", with: "\\f")
                .replacingOccurrences(of: "\u{000a}", with: "\\n")
                .replacingOccurrences(of: "\u{000d}", with: "\\r")
                .replacingOccurrences(of: "\u{0009}", with: "\\t")
            return "\"\(substituted)\""
        case let .boolean(boolean):
            return boolean ? "true" : "false"
        case .null:
            return "null"
        case let .enum(`enum`):
            return `enum`.description
        case let .list(list):
            return "[" + list.map { $0.description }.joined(separator: " ") + "]"
        case let .object(object):
            return "{ " + object.map { "\($0.key): \($0.value)" }.joined(separator: ", ") + " }"
        }
    }
}

