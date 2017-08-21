@testable import PersistQL
import XCTest

class GraphQLVariableTests: XCTestCase {
    func testDescription() {
        let variable = GraphQL.Variable("mdiep")
        XCTAssertEqual(variable.description, "$mdiep")
    }
}
