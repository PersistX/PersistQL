@testable import PersistQL
import XCTest

class GraphQLOperationDescriptionTests: XCTestCase {
    func test_query_withoutName() {
        let operation = GraphQL.Operation(
            type: .query,
            name: nil,
            selectionSet: [
                GraphQL.Selection.field(GraphQL.Field(name: "name"))
            ]
        )
        XCTAssertEqual(operation.description, "query { name }")
    }
    
    func test_query_withName() {
        let operation = GraphQL.Operation(
            type: .query,
            name: "foo",
            selectionSet: [
                GraphQL.Selection.field(GraphQL.Field(name: "name"))
            ]
        )
        XCTAssertEqual(operation.description, "query foo { name }")
    }
    
    func test_mutation() {
        let operation = GraphQL.Operation(
            type: .mutation,
            name: nil,
            selectionSet: [
                GraphQL.Selection.field(GraphQL.Field(name: "name"))
            ]
        )
        XCTAssertEqual(operation.description, "mutation { name }")
        
    }
    
    func test_subscription() {
        let operation = GraphQL.Operation(
            type: .subscription,
            name: nil,
            selectionSet: [
                GraphQL.Selection.field(GraphQL.Field(name: "name"))
            ]
        )
        XCTAssertEqual(operation.description, "subscription { name }")
        
    }
}
