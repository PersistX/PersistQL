import Foundation

extension GraphQL {
    /// A field in a GraphQL document.
    struct Field {
        /// The aliased name of the field, or `nil` if it isn't aliased.
        var alias: Name?
        
        /// The name of the field.
        var name: Name
        
        /// The arguments passed to the field, or `nil` if it has no arguments.
        var arguments: Arguments?
        
        /// The selection set fo this field, or `nil` if it has no selection set.
        var selectionSet: SelectionSet?
        
        init(
            alias: Name? = nil,
            name: Name,
            arguments: Arguments? = nil,
            selectionSet: SelectionSet? = nil
        ) {
            self.alias = alias
            self.name = name
            self.arguments = arguments
            self.selectionSet = selectionSet
        }
    }
}

extension GraphQL.Field: Hashable {
    var hashValue: Int {
        let arguments = self.arguments?.map { $0.key.hashValue ^ $0.value.hashValue }.reduce(0, ^)
        return (alias?.hashValue ?? 0)
            ^ name.hashValue
            ^ (arguments ?? 0)
            ^ (selectionSet?.hashValue ?? 0)
    }
    
    static func ==(lhs: GraphQL.Field, rhs: GraphQL.Field) -> Bool {
        switch (lhs.arguments, rhs.arguments) {
        case (nil, .some), (.some, nil):
            return false
        case let (lhs?, rhs?) where lhs != rhs:
            return false
        default:
            return lhs.alias == rhs.alias
                && lhs.name == rhs.name
                && lhs.selectionSet == rhs.selectionSet
        }
    }
}

extension GraphQL.Field: CustomStringConvertible {
    var description: String {
        var result = ""
        
        if let alias = alias {
            result += alias.description + ": "
        }
        
        result += name.description
        
        if let arguments = arguments {
            result += "(" + arguments.map { "\($0.key): \($0.value)" }.joined(separator: ", ") + ")"
        }
        
        if let selectionSet = selectionSet {
            result += " { \(selectionSet) }"
        }
        
        return result
    }
}


