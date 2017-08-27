import Foundation
import Schemata

/// A query that's exposed from a GraphQL API.
public struct Query<Model: Schemata.Model> {
    let name: GraphQL.Name
    let arguments: GraphQL.Arguments
    
    public init(name: String, arguments: [String: Any]) {
        self.name = GraphQL.Name(name)
        self.arguments = [:]
    }
}
