import Foundation

internal struct GraphQL {
    typealias Arguments = [Name: Value]
    typealias SelectionSet = Set<Selection>
    
    let operations: [Operation]
    let fragments: [Fragment]
}

extension GraphQL: Hashable {
    var hashValue: Int {
        return operations.map { $0.hashValue }.reduce(0, ^)
            ^ fragments.map { $0.hashValue }.reduce(0, ^)
    }
    
    static func ==(lhs: GraphQL, rhs: GraphQL) -> Bool {
        return lhs.operations == rhs.operations
            && lhs.fragments == rhs.fragments
    }
}

extension GraphQL: CustomStringConvertible {
    var description: String {
        let operations = self.operations.map { $0.description }
        let fragments = self.fragments.map { $0.description }
        return (operations + fragments).joined(separator: " ")
    }
}
