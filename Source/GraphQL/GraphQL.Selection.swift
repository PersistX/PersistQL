import Foundation

extension GraphQL {
    /// A selection in a GraphQL document.
    enum Selection {
        case field(Field)
    }
}

extension GraphQL.Selection: Hashable {
    var hashValue: Int {
        switch self {
        case let .field(field):
            return field.hashValue
        }
    }
    
    static func ==(lhs: GraphQL.Selection, rhs: GraphQL.Selection) -> Bool {
        switch (lhs, rhs) {
        case let (.field(lhs), .field(rhs)):
            return lhs == rhs
        }
    }
}

extension GraphQL.Selection: CustomStringConvertible {
    var description: String {
        switch self {
        case let .field(field):
            return field.description
        }
    }
}


