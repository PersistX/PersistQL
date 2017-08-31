import Foundation
import Result
import Schemata

/// An object that makes GraphQL requests over the network.
public final class Client {
    fileprivate let urlRequest: URLRequest
    fileprivate let urlSession: URLSession
    
    public init(
        url: URL,
        headers: [String: String] = [:],
        urlSession: URLSession = .shared
    ) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        for (field, value) in headers {
            urlRequest.setValue(value, forHTTPHeaderField: field)
        }
        self.urlRequest = urlRequest
        self.urlSession = urlSession
    }
}

extension Client {
    /// Create a URL request for the given `Request`.
    func urlRequest<Projection>(for request: Request<Projection>) -> URLRequest {
        var urlRequest = self.urlRequest
        urlRequest.httpBody = request.json
        return urlRequest
    }
    
    /// Query the GraphQL server for a given projection.
    public func perform<Projection: ModelProjection>(
        _ query: Query<Projection.Model>,
        completionHandler: @escaping (Result<Projection, NSError>) -> Void
    ) {
        let request = Request<Projection>(query)
        let urlRequest = self.urlRequest(for: request)
        let task = urlSession.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completionHandler(.failure(error as NSError))
            } else {
                return completionHandler(request.value(forJSON: data!))
            }
        }
        task.resume()
    }
}

