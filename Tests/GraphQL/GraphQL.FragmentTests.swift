@testable import PersistQL
import XCTest

class GraphQLFragmentDescriptionTests: XCTestCase {
    func test() {
        let fragment = GraphQL.Fragment(
            name: "friendFields",
            type: "User",
            selectionSet: [
                .field(GraphQL.Field(name: "id")),
                .field(GraphQL.Field(name: "name")),
            ]
        )
        
        let permutations = [
            "fragment friendFields on User { id name }",
            "fragment friendFields on User { name id }",
        ]
        
        XCTAssert(permutations.contains(fragment.description))
    }
}
