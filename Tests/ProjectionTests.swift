@testable import PersistQL
import XCTest

class ProjectionTests: XCTestCase {
    func test_selectionSet() {
        let expected: GraphQL.SelectionSet = [
            .field(GraphQL.Field(name: "title")),
            .field(GraphQL.Field(
                name: "author",
                selectionSet: [
                    .field(GraphQL.Field(name: "id")),
                    .field(GraphQL.Field(name: "name")),
                ]
            )),
        ]
        XCTAssertEqual(BookViewModel.projection.selectionSet, expected)
    }
}
