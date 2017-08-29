import Result
import Schemata

extension Projection {
    struct DecodeError: Error {
        let keyPath: PartialKeyPath<Model>
    }
    
    var selectionSet: GraphQL.SelectionSet {
        let schema = Model.schema
        let selections = keyPaths
            .map { keyPath -> GraphQL.Field in
                return schema
                    .properties(for: keyPath)
                    .reversed()
                    .reduce(nil) { (field, property) in
                        return GraphQL.Field(
                            name: GraphQL.Name(property.path),
                            selectionSet: field.map { GraphQL.SelectionSet([ .field($0) ]) }
                        )
                    }!
            }
            .map(GraphQL.Selection.field)
        return GraphQL.SelectionSet(selections)
    }
    
    func value(forJSON json: Any) -> Result<Value, DecodeError> {
        var values: [PartialKeyPath<Model>: Any] = [:]
        
        let schema = Model.schema
        for keyPath in keyPaths {
            let error = DecodeError(keyPath: keyPath)
            var value = json
            for property in schema.properties(for: keyPath) {
                guard let object = value as? [String: Any] else { return .failure(error) }
                let newValue = object[property.path]
                
                switch property.type {
                case .toMany:
                    fatalError()
                    
                case .toOne:
                    if let newValue = newValue {
                        value = newValue
                    } else {
                        return .failure(error)
                    }
                    
                case let .value(type, nullable: nullable):
                    let primitive: Primitive
                    if let newValue = newValue {
                        if let newValue = newValue as? Double {
                            primitive = .double(newValue)
                        } else if let newValue = newValue as? Int {
                            primitive = .int(newValue)
                        } else if let newValue = newValue as? String {
                            primitive = .string(newValue)
                        } else {
                            return .failure(error)
                        }
                    } else if nullable {
                        primitive = .null
                    } else {
                        return .failure(error)
                    }
                    
                    switch type.anyValue.decode(primitive) {
                    case let .success(newValue):
                        value = newValue
                    case .failure:
                        return .failure(error)
                    }
                }
            }
            values[keyPath] = value
        }
        
        return .success(makeValue(values))
    }
}
