import Result
import Schemata

internal struct Request<Projection: ModelProjection> {
    let query: Query<Projection.Model>
    
    init(_ query: Query<Projection.Model>) {
        self.query = query
    }
}

extension Request {
    struct DecodeError: Error {
    }
    
    var json: Data {
        let operation = GraphQL.Operation(
            type: .query,
            name: nil,
            selectionSet: [
                .field(GraphQL.Field(
                    name: query.name,
                    arguments: query.arguments,
                    selectionSet: Projection.projection.selectionSet
                ))
            ]
        )
        let json = ["query": operation.description]
        return try! JSONSerialization.data(withJSONObject: json)
    }
    
    func value(forJSON data: Data) -> Result<Projection, NSError> {
        return Result(try JSONSerialization.jsonObject(with: data))
            .flatMap { json in
                guard
                    let root = json as? [String: Any],
                    let data = root["data"] as? [String: Any],
                    let query = data[query.name.description] as? [String: Any]
                else {
                    return .failure(DecodeError() as NSError)
                }
                
                return Projection.projection
                    .value(forJSON: query)
                    .mapError { $0 as NSError }
            }
    }
}
