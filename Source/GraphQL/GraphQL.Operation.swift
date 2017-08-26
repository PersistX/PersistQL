import Foundation

extension GraphQL {
    /// An operation type within a GraphQL document.
    enum OperationType {
        case query
        case mutation
        case subscription
    }
    
    /// An operation within a GraphQL document.
    struct Operation {
        let type: OperationType
        let name: Name?
        let selectionSet: SelectionSet
    }
}

extension GraphQL.OperationType: Hashable {
    var hashValue: Int {
        return description.hashValue
    }
    
    static func ==(lhs: GraphQL.OperationType, rhs: GraphQL.OperationType) -> Bool {
        switch (lhs, rhs) {
        case (.query, .query),
             (.mutation, .mutation),
             (.subscription, .subscription):
            return true
        default:
            return false
        }
    }
}

extension GraphQL.OperationType: CustomStringConvertible {
    var description: String {
        switch self {
        case .query:
            return "query"
        case .mutation:
            return "mutation"
        case .subscription:
            return "subscription"
        }
    }
}

extension GraphQL.Operation: Hashable {
    var hashValue: Int {
        return type.hashValue ^ selectionSet.hashValue
    }
    
    static func ==(lhs: GraphQL.Operation, rhs: GraphQL.Operation) -> Bool {
        return lhs.type == rhs.type
            && lhs.name == rhs.name
            && lhs.selectionSet == rhs.selectionSet
    }
}

extension GraphQL.Operation: CustomStringConvertible {
    var description: String {
        let selectionSet = self.selectionSet.map { $0.description }.joined(separator: " ")
        return "\(type) "
            + (name.map { "\($0) " } ?? "")
            + "{ \(selectionSet) }"
    }
}
