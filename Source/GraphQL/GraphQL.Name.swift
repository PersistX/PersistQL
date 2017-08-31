import Foundation

extension GraphQL {
    /// A name in a GraphQL document.
    public struct Name {
        static let regex = try! NSRegularExpression(pattern: "^[_A-Za-z][_0-9A-Za-z]*$")
        
        fileprivate var string: String
        
        public init(_ string: String) {
            precondition(Name.regex.firstMatch(in: string, range: NSRange(location: 0, length: string.count)) != nil)
            self.string = string
        }
    }
}

extension GraphQL.Name: Hashable {
    public var hashValue: Int {
        return string.hashValue
    }
    
    public static func ==(lhs: GraphQL.Name, rhs: GraphQL.Name) -> Bool {
        return lhs.string == rhs.string
    }
}

extension GraphQL.Name: CustomStringConvertible {
    public var description: String {
        return string
    }
}

extension GraphQL.Name: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self.init(value)
    }
}
