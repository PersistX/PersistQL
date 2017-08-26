@testable import PersistQL
import XCTest

class GraphQLValueInitWithConstantTests: XCTestCase {
    func testInt() {
        let constant = GraphQL.Constant.int(5)
        XCTAssertEqual(GraphQL.Value(constant), .int(5))
    }
    
    func testFloat() {
        let constant = GraphQL.Constant.float(3.14)
        XCTAssertEqual(GraphQL.Value(constant), .float(3.14))
    }
    
    func testString() {
        let constant = GraphQL.Constant.string("foo")
        XCTAssertEqual(GraphQL.Value(constant), .string("foo"))
    }
    
    func testBoolean() {
        let constant = GraphQL.Constant.boolean(true)
        XCTAssertEqual(GraphQL.Value(constant), .boolean(true))
    }
    
    func testNull() {
        let constant = GraphQL.Constant.null
        XCTAssertEqual(GraphQL.Value(constant), .null)
    }
    
    func testEnum() {
        let constant = GraphQL.Constant.enum("FOO")
        XCTAssertEqual(GraphQL.Value(constant), .enum("FOO"))
    }
    
    func testList() {
        let constant = GraphQL.Constant.list([.int(5)])
        XCTAssertEqual(GraphQL.Value(constant), .list([.int(5)]))
    }
    
    func testObject() {
        let constant = GraphQL.Constant.object(["foo": .string("bar")])
    XCTAssertEqual(GraphQL.Value(constant), .object(["foo": .string("bar")]))
    }
}

class GraphQLValueDescriptionTests: XCTestCase {
    func testVariable() {
        let variable = GraphQL.Variable("mdiep")
        let value = GraphQL.Value.variable(variable)
        XCTAssertEqual(value.description, variable.description)
    }
    
    func testInt() {
        let value = GraphQL.Value.int(5)
        XCTAssertEqual(value.description, "5")
    }
    
    func testFloat() {
        let value = GraphQL.Value.float(3.14)
        XCTAssertEqual(value.description, "3.14")
    }
    
    func testString() {
        let value = GraphQL.Value.string("a \u{005c} \u{0022} \u{002f} \u{0008} \u{000c} \u{000a} \u{000d} \u{0009} ✊️")
        XCTAssertEqual(value.description, "\"a \\\\ \\\" \\/ \\b \\f \\n \\r \\t ✊️\"")
    }
    
    func testBoolean() {
        XCTAssertEqual(GraphQL.Value.boolean(true).description, "true")
        XCTAssertEqual(GraphQL.Value.boolean(false).description, "false")
    }
    
    func testNull() {
        XCTAssertEqual(GraphQL.Value.null.description, "null")
    }
    
    func testEnum() {
        XCTAssertEqual(GraphQL.Value.enum(GraphQL.Name("TEST")).description, "TEST")
    }
    
    func testList() {
        let value = GraphQL.Value.list([
            .variable(GraphQL.Variable("mdiep")),
            .int(5),
            .float(3.14),
        ])
        XCTAssertEqual(value.description, "[$mdiep 5 3.14]")
    }
    
    func testObject() {
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

