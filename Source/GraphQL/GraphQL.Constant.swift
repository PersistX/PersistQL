import Foundation

extension GraphQL {
    /// A constant value in a GraphQL document.
    enum Constant {
        case int(Int)
        case float(Float)
        case string(String)
        case boolean(Bool)
        case null
        case `enum`(Name)
        case list([Constant])
        case object([Name: Constant])
    }
}

extension GraphQL.Constant: Hashable {
    var hashValue: Int {
        return GraphQL.Value(self).hashValue
    }
    
    static func ==(lhs: GraphQL.Constant, rhs: GraphQL.Constant) -> Bool {
        return GraphQL.Value(lhs) == GraphQL.Value(rhs)
    }
}

extension GraphQL.Constant: CustomStringConvertible {
    var description: String {
        return GraphQL.Value(self).description
    }
}


