import Schemata

extension Projection {
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
}
