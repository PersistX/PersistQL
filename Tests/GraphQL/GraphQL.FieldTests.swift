@testable import PersistQL
import XCTest

class GraphQLFieldDescriptionTests: XCTestCase {
    func testNameOnly() {
        let field = GraphQL.Field(name: "mdiep")
        XCTAssertEqual(field.description, "mdiep")
    }
    
    func testWithAlias() {
        let field = GraphQL.Field(alias: "matt", name: "mdiep")
        XCTAssertEqual(field.description, "matt: mdiep")
    }
    
    func testWithArguments() {
        let field = GraphQL.Field(
            name: "mdiep",
            arguments: [
                "foo": .int(5),
                "bar": .string("baz")
            ]
        )
        let permutations = [
            "mdiep(foo: 5, bar: \"baz\")",
            "mdiep(bar: \"baz\", foo: 5)",
        ]
        XCTAssert(permutations.contains(field.description))
    }
    
    func testWithSelectionSet() {
        let field = GraphQL.Field(
            name: "mdiep",
            selectionSet: [
                .field(.init(name: "id")),
                .field(.init(name: "name")),
            ]
        )
        let permutations = [
            "mdiep { id name }",
            "mdiep { name id }",
        ]
        XCTAssert(permutations.contains(field.description))
    }
    
    func testWithEverything() {
        let field = GraphQL.Field(
            alias: "matt",
            name: "mdiep",
            arguments: [
                "foo": .int(5),
                "bar": .string("baz")
            ],
            selectionSet: [
                .field(.init(name: "id")),
                .field(.init(name: "name")),
            ]
        )
        let permutations = [
            "matt: mdiep(foo: 5, bar: \"baz\") { id name }",
            "matt: mdiep(foo: 5, bar: \"baz\") { name id }",
            "matt: mdiep(bar: \"baz\", foo: 5) { id name }",
            "matt: mdiep(bar: \"baz\", foo: 5) { name id }",
        ]
        XCTAssert(permutations.contains(field.description))
        
    }
}


