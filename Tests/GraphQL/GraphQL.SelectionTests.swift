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
}


