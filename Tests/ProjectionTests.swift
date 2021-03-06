@testable import PersistQL
import XCTest

class ProjectionSelectionSetTests: XCTestCase {
    func test() {
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

class ProjectionValueForJSONTests: XCTestCase {
    func testToOne() {
        let expected = BookViewModel.theMartianChronicles
        let json: Any = [
            "title": expected.title,
            "author": [
                "id": expected.authorID.string,
                "name": expected.authorName,
            ]
        ]
        let actual = BookViewModel.projection.value(forJSON: json)
        
        XCTAssertEqual(actual.value, expected)
    }
    
    func testToOneOptional() {
    }
    
    func testToMany() {
    }
    
    func testDateValue() {
    }
    
    func testDoubleValue() {
    }
    
    func testIntValue() {
    }
    
    func testNullValue() {
    }
}
