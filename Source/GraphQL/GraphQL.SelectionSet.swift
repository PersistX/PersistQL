import Foundation

extension GraphQL {
    /// A set of fields and fragments to be selected.
    struct SelectionSet {
        let selections: Set<Selection>
    }
}

extension GraphQL.SelectionSet: Hashable {
    var hashValue: Int {
        return selections.map { $0.hashValue }.reduce(0, ^)
    }
    
    static func ==(lhs: GraphQL.SelectionSet, rhs: GraphQL.SelectionSet) -> Bool {
        return lhs.selections == rhs.selections
    }
}

extension GraphQL.SelectionSet: CustomStringConvertible {
    var description: String {
        return selections.map { $0.description }.joined(separator: " ")
    }
}

extension GraphQL.SelectionSet: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: GraphQL.Selection...) {
        selections = Set(elements)
    }
}
