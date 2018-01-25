# PersistQL ✊📡
Projection-based GraphQL Clients and Servers in Swift

_PersistQL is alpha-quality software. It currently has a number of limitations._

[GraphQL][] makes APIs much more flexible. Instead of hardcoding endpoints that return specific data, GraphQL lets clients decide which relationships and properties are returned. But how can this information be encoded in the type system in a way that retains flexibility but maintains type safety?

[GraphQL]: http://graphql.org

PersistQL tries to answer this by describing GraphQL schemas in the type system and letting clients _project_ these schemas onto their own types to create requests.

```swift
// A description of the GraphQL schema
final class Book {
  struct ISBN {
    let string: String
  }
  
  let id: ISBN
  let title: String
  let author: Author
}

extension Book: Model {
  static let schema = Schema(
    Book.init,
    \.id ~ "isbn",
    \.title ~ "title",
    \.author ~ "author"
  )
}

final class Author {
    let id: UUID
    let name: String
    let books: Set<Book>
}

extension Author {
  static let schema = Schema(
    Author.init,
    \.id ~ "id",
    \.name ~ "name",
    \.books ~ "books"
  )
}

// A local view model, which is projected from the schema
// It can be used to create a GraphQL query
struct BookViewModel {
  let isbn: ISBN
  let title: String
  let author: String
}

extension BookViewModel: ModelProjection {
  static let projection = Projection<Book, BookViewModel>(
    BookViewModel.init,
    \.id,
    \.title,
    \.author.name
  )
}
```

## License
PersistQL is available under the MIT license.
