import Foundation
import Schemata

/// A query that's exposed from a GraphQL API.
public struct Query<Model: Schemata.Model> {
    let name: GraphQL.Name
    let arguments: GraphQL.Arguments
    
    public init(name: GraphQL.Name, arguments: [GraphQL.Name: GraphQL.Constant]) {
        self.name = name
        self.arguments = arguments.mapValues(GraphQL.Value.init)
    }
}
