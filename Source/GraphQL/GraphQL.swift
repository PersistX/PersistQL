import Foundation

public struct GraphQL {
    typealias Arguments = [Name: Value]
    
    let operations: [Operation]
    let fragments: [Fragment]
}

extension GraphQL: Hashable {
    public var hashValue: Int {
        return operations.map { $0.hashValue }.reduce(0, ^)
            ^ fragments.map { $0.hashValue }.reduce(0, ^)
    }
    
    public static func ==(lhs: GraphQL, rhs: GraphQL) -> Bool {
        return lhs.operations == rhs.operations
            && lhs.fragments == rhs.fragments
    }
}

extension GraphQL: CustomStringConvertible {
    public var description: String {
        let operations = self.operations.map { $0.description }
        let fragments = self.fragments.map { $0.description }
        return (operations + fragments).joined(separator: " ")
    }
}
