import Foundation

extension GraphQL {
    /// A set of fields and fragments to be selected.
    struct SelectionSet {
        let selections: Set<Selection>
        
        init(_ selections: Set<Selection>) {
            var fields: [Field: SelectionSet?] = [:]
            var merged: Set<Selection> = []
            
            for selection in selections {
                switch selection {
                case .fragment, .inlineFragment:
                    merged.insert(selection)
                    
                case let .field(field):
                    var copy = field
                    copy.selectionSet = nil
                    
                    if let set = fields[copy] {
                        let merged: SelectionSet?
                        switch (field.selectionSet, set) {
                        case let (nil, set?), let (set?, nil):
                            merged = set
                        case (nil, nil):
                            merged = nil
                        case let (set1?, set2?):
                            merged = SelectionSet(set1.selections.union(set2.selections))
                        }
                        fields[copy] = merged
                    } else {
                        fields[copy] = field.selectionSet
                    }
                }
            }
            
            for (field, set) in fields {
                var copy = field
                copy.selectionSet = set
                merged.insert(.field(copy))
            }
            
            self.selections = merged
        }
    }
}

extension GraphQL.SelectionSet: Hashable {
    var hashValue: Int {
        return selections.map { $0.hashValue }.reduce(0, ^)
    }
    
    static func ==(lhs: GraphQL.SelectionSet, rhs: GraphQL.SelectionSet) -> Bool {
        return lhs.selections == rhs.selections
    }
}

extension GraphQL.SelectionSet: CustomStringConvertible {
    var description: String {
        return selections.map { $0.description }.joined(separator: " ")
    }
}

extension GraphQL.SelectionSet: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: GraphQL.Selection...) {
        self.init(Set(elements))
    }
}
