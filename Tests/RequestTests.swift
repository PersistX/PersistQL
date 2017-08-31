@testable import PersistQL
import XCTest

class RequestDecodeTests: XCTestCase {
    func test() {
        let expected = BookViewModel.theMartianChronicles
        let json: Any = [
            "data": [
                "book": [
                    "title": expected.title,
                    "author": [
                        "id": expected.authorID.string,
                        "name": expected.authorName,
                    ]
                ]
            ]
        ]
        let data = try! JSONSerialization.data(withJSONObject: json)
        
        let query = Book.with(title: expected.title)
        let request = Request<BookViewModel>(query)
        let decoded = request.value(forJSON: data)
        
        XCTAssertEqual(decoded.value, expected)
    }
}

class RequestEncodeTests: XCTestCase {
    func test() {
        let title = BookViewModel.theMartianChronicles.title
        let permutations = [
                "title author { id name }",
                "title author { name id }",
                "author { id name } title",
                "author { name id } title",
            ]
            .map { fields -> Any in
                return [ "query": "query { book(title: \"\(title)\") { \(fields) } }" ]
            }
            .map { json in
                return try! JSONSerialization.data(withJSONObject: json)
            }
        
        let query = Book.with(title: title)
        let request = Request<BookViewModel>(query)
        let json = request.json
        
        XCTAssert(permutations.contains(json))
    }
}
