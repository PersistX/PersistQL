@testable import PersistQL
import XCTest

class SelectionSetInitTests: XCTestCase {
    func testMergesFields() {
        let expected: GraphQL.SelectionSet = [
            .field(GraphQL.Field(
                alias: "foo",
                name: "user",
                arguments: ["login": .string("mdiep")],
                selectionSet: [
                    .field(GraphQL.Field(name: "id")),
                    .field(GraphQL.Field(name: "login")),
                ]
            )),
        ]
        
        let actual: GraphQL.SelectionSet = [
            .field(GraphQL.Field(
                alias: "foo",
                name: "user",
                arguments: ["login": .string("mdiep")],
                selectionSet: [
                    .field(GraphQL.Field(name: "id")),
                ]
            )),
            .field(GraphQL.Field(
                alias: "foo",
                name: "user",
                arguments: ["login": .string("mdiep")],
                selectionSet: [
                    .field(GraphQL.Field(name: "login")),
                ]
            )),
        ]
        
        XCTAssertEqual(actual, expected)
    }
    
    func testMergesFieldsWithoutAliasOrArguments() {
        let expected: GraphQL.SelectionSet = [
            .field(GraphQL.Field(
                name: "user",
                selectionSet: [
                    .field(GraphQL.Field(name: "id")),
                    .field(GraphQL.Field(name: "login")),
                ]
            )),
        ]
        
        let actual: GraphQL.SelectionSet = [
            .field(GraphQL.Field(
                name: "user",
                selectionSet: [
                    .field(GraphQL.Field(name: "id")),
                ]
            )),
            .field(GraphQL.Field(
                name: "user",
                selectionSet: [
                    .field(GraphQL.Field(name: "login")),
                ]
            )),
        ]
        
        XCTAssertEqual(actual, expected)
    }
    
    func testDoesNotMergeFieldsWithDifferentAliases() {
        let set: GraphQL.SelectionSet = [
            .field(GraphQL.Field(
                alias: "foo",
                name: "user",
                selectionSet: [
                    .field(GraphQL.Field(name: "id")),
                ]
            )),
            .field(GraphQL.Field(
                alias: "bar",
                name: "user",
                selectionSet: [
                    .field(GraphQL.Field(name: "login")),
                ]
            )),
        ]
        
        XCTAssertEqual(set.selections.count, 2)
    }
    
    func testDoesNotMergeFieldsWithDifferentArguments() {
        let set: GraphQL.SelectionSet = [
            .field(GraphQL.Field(
                name: "user",
                arguments: ["login": .string("mdiep")],
                selectionSet: [
                    .field(GraphQL.Field(name: "id")),
                ]
            )),
            .field(GraphQL.Field(
                name: "user",
                arguments: ["login": .string("robrix")],
                selectionSet: [
                    .field(GraphQL.Field(name: "login")),
                ]
            )),
        ]
        
        XCTAssertEqual(set.selections.count, 2)
    }
}
