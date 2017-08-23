import Foundation

extension GraphQL {
    /// The primary unit of composition in GraphQL.
    struct Fragment {
        /// The name of the fragment.
        var name: Name
        
        /// The type that the fragment applies to.
        var type: Name
        
        /// The fields that will be selected as part of the fragment.
        var selectionSet: SelectionSet
    }
}

extension GraphQL.Fragment: Hashable {
    var hashValue: Int {
        return name.hashValue ^ type.hashValue
    }
    
    static func ==(lhs: GraphQL.Fragment, rhs: GraphQL.Fragment) -> Bool {
        return lhs.name == rhs.name
            && lhs.type == rhs.type
            && lhs.selectionSet == rhs.selectionSet
    }
}

extension GraphQL.Fragment: CustomStringConvertible {
    var description: String {
        return "fragment \(name) on \(type) { "
            + selectionSet.map { $0.description }.joined(separator: " ")
            + " }"
    }
}
