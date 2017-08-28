import Foundation

extension GraphQL {
    /// A selection in a GraphQL document.
    enum Selection {
        case field(Field)
        case fragment(Name)
        case inlineFragment(type: Name, SelectionSet)
    }
}

extension GraphQL.Selection: Hashable {
    var hashValue: Int {
        switch self {
        case let .field(field):
            return field.hashValue
        case let .fragment(name):
            return name.hashValue
        case let .inlineFragment(name, selectionSet):
            return name.hashValue ^ selectionSet.hashValue
        }
    }
    
    static func ==(lhs: GraphQL.Selection, rhs: GraphQL.Selection) -> Bool {
        switch (lhs, rhs) {
        case let (.field(lhs), .field(rhs)):
            return lhs == rhs
        case let (.fragment(lhs), .fragment(rhs)):
            return lhs == rhs
        case let (.inlineFragment(lhsType, lhsSet), .inlineFragment(rhsType, rhsSet)):
            return lhsType == rhsType && lhsSet == rhsSet
        default:
            return false
        }
    }
}

extension GraphQL.Selection: CustomStringConvertible {
    var description: String {
        switch self {
        case let .field(field):
            return field.description
        case let .fragment(name):
            return "...\(name)"
        case let .inlineFragment(type, selectionSet):
            return "... on \(type) { \(selectionSet) }"
        }
    }
}


