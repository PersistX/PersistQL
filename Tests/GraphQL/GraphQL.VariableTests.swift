@testable import PersistQL
import XCTest

class GraphQLVariableTests: XCTestCase {
    func testDescription() {
        let variable = GraphQL.Variable(GraphQL.Name("mdiep"))
        XCTAssertEqual(variable.description, "$mdiep")
    }
}
