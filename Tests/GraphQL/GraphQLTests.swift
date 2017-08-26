@testable import PersistQL
import XCTest

class GraphQLDescriptionTests: XCTestCase {
    func test() {
        let operations = [
            GraphQL.Operation(
                type: .query,
                name: "foo",
                selectionSet: [
                    .field(GraphQL.Field(name: "name"))
                ]
            ),
            GraphQL.Operation(
                type: .query,
                name: "bar",
                selectionSet: [
                    .fragment("baz")
                ]
            )
        ]
        let fragments = [
            GraphQL.Fragment(
                name: "baz",
                type: "User",
                selectionSet: [
                    .field(GraphQL.Field(name: "id")),
                    .field(GraphQL.Field(name: "name")),
                ]
            )
        ]
        let graphQL = GraphQL(operations: operations, fragments: fragments)
        XCTAssertEqual(graphQL.description, "query foo { name } query bar { ...baz } fragment baz on User { id name }")
    }
}
