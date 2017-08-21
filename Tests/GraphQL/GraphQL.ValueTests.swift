@testable import PersistQL
import XCTest

class GraphQLValueTests: XCTestCase {
    func testVariableDescription() {
        let variable = GraphQL.Variable("mdiep")
        let value = GraphQL.Value.variable(variable)
        XCTAssertEqual(value.description, variable.description)
    }
    
    func testIntDescription() {
        let value = GraphQL.Value.int(5)
        XCTAssertEqual(value.description, "5")
    }
    
    func testFloatDescription() {
        let value = GraphQL.Value.float(3.14)
        XCTAssertEqual(value.description, "3.14")
    }
    
    func testStringDescription() {
        let value = GraphQL.Value.string("a \u{005c} \u{0022} \u{002f} \u{0008} \u{000c} \u{000a} \u{000d} \u{0009} ✊️")
        XCTAssertEqual(value.description, "\"a \\\\ \\\" \\/ \\b \\f \\n \\r \\t ✊️\"")
    }
    
    func testBooleanDescription() {
        XCTAssertEqual(GraphQL.Value.boolean(true).description, "true")
        XCTAssertEqual(GraphQL.Value.boolean(false).description, "false")
    }
    
    func testNullDescription() {
        XCTAssertEqual(GraphQL.Value.null.description, "null")
    }
    
    func testEnumDescription() {
        XCTAssertEqual(GraphQL.Value.enum(GraphQL.Name("TEST")).description, "TEST")
    }
    
    func testListDescription() {
        let value = GraphQL.Value.list([
            .variable(GraphQL.Variable("mdiep")),
            .int(5),
            .float(3.14),
        ])
        XCTAssertEqual(value.description, "[$mdiep 5 3.14]")
    }
    
    func testObjectDescription() {
        let value = GraphQL.Value.object([
            "foo": .int(5),
            "bar": .float(3.14),
        ])
        let permutations = [
            "{ foo: 5, bar: 3.14 }",
            "{ bar: 3.14, foo: 5 }",
        ]
        let description = value.description
        XCTAssert(permutations.contains(description), "\(description)")
    }
}

