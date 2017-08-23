@testable import PersistQL
import XCTest

class GraphQLSelectionDescriptionTests: XCTestCase {
    func testField() {
        let field = GraphQL.Field(name: "mdiep")
        let selection = GraphQL.Selection.field(field)
        XCTAssertEqual(selection.description, field.description)
    }
    
    func testFragment() {
        let selection = GraphQL.Selection.fragment("foo")
        XCTAssertEqual(selection.description, "...foo")
    }
    
    func testInlineFragment() {
        let selection = GraphQL.Selection.inlineFragment(
            type: "User",
            [
                .field(GraphQL.Field(name: "id")),
                .field(GraphQL.Field(name: "name")),
            ]
        )
        
        let permutations = [
            "... on User { id name }",
            "... on User { name id }",
        ]
        
        XCTAssert(permutations.contains(selection.description))
    }
}


