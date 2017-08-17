import Foundation

extension GraphQL {
    /// A variable in a GraphQL document.
    struct Variable {
        fileprivate var name: Name
        
        init(_ name: Name) {
            self.name = name
        }
    }
}

extension GraphQL.Variable: Hashable {
    var hashValue: Int {
        return name.hashValue
    }
    
    static func ==(lhs: GraphQL.Variable, rhs: GraphQL.Variable) -> Bool {
        return lhs.name == rhs.name
    }
}

extension GraphQL.Variable: CustomStringConvertible {
    var description: String {
        return "$\(name)"
    }
}

