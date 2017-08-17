@testable import PersistQL
import XCTest

class GraphQLNameTests: XCTestCase {
    func testDescription() {
        let name = GraphQL.Name("mdiep")
        XCTAssertEqual(name.description, "mdiep")
    }
}

