//
//  API.swift
//  iOS Demo
//
//  Created by Mo Moosa on 15/05/2022.
//

import Foundation

enum HTTPStatusCode: Int {
    case okay = 200
    case redirect = 300
    case clientError = 400
    case unauthorized = 401
    case serverError = 500
}

class API {
    enum HeaderKey: String {
        case appID = "AppId"
        case apiVersion = "apiVersion"
        case appVersion = "appVersion"
        case authorization = "Authorization"
        case contentType = "Content-Type"
    }

    enum Error: Swift.Error {
        case noRequestURL
        case invalidResponseData
        case couldNotResolveURL
        case noBearerTokenForAuthenticatedRequest
        case invalidURLPathOrQuery
        case noStatusCode
    }
    /// The base URL, without host.
    /// - Example: for `https://apple.com`, this propertly should return `apple.com`
    var baseURL: String {
        fatalError("Subclasses should override this.")
    }

    private var urlSession = URLSession.shared
    private(set) var decoder = JSONDecoder()
    private(set) var encoder = JSONEncoder()

    // MARK: - Request Decoration
    func makeRequest<R: Decodable>(for endpoint: Endpoint<R>,
                                   with session: Session? = UserManager.current.session,
                                   data: Data?) throws -> URLRequest {


        var components = URLComponents()
        components.scheme = "https"
        components.host = baseURL
        components.path = "/" + endpoint.path
        components.queryItems = endpoint.queryItems.isEmpty ? nil : endpoint.queryItems

        // If either the path or the query items passed contained
        // invalid characters, we'll get a nil URL back:
        guard let url = components.url else {
            throw Error.invalidURLPathOrQuery
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        switch endpoint.method {
        case .post:
            request.httpBody = data
        default:
            break
        }

        try prepare(request: &request, authenticated: endpoint.authenticated, session: session)
        return request
    }

    func prepare(request: inout URLRequest, authenticated: Bool, session: Session?) throws {
        if authenticated {
            guard let token = session?.bearerToken else {
                throw Error.noBearerTokenForAuthenticatedRequest
            }
            request.addValue("Bearer \(token)", forHTTPHeaderField: HeaderKey.authorization.rawValue)
        }
    }

    func send<D: Decodable>(request: URLRequest) async throws -> D {
        let responseData: Data
        let responseMetaData: URLResponse
#if DEBUG

        print("Sending \(request.cURL(pretty: true))")
#endif
        if #available(iOS 15.0, *) {
            let (data, response) = try await URLSession.shared.data(for: request)
            responseData = data
            responseMetaData = response
        } else {
            // TODO: Remove compatibility layer.
            let (data, response) = try await URLSession.shared.dataWithCompatibilityAPI(from: request)
            responseData = data
            responseMetaData = response
        }

#if DEBUG
        guard let url = request.url else {
            throw Error.noRequestURL
        }

        let responseString = responseData.prettyPrintedJSONString ?? "Unable to form description for \(url) response" as NSString
        print("Response received for \(url)")
        print("-------START-----------")
        print(responseString)
        print("-------END-----------")
#endif
        try handle(data: responseData, response: responseMetaData)
        return try decode(from: responseData)
    }

    private func handle(data: Data, response: URLResponse) throws {
        if try statusCode(for: response) == .unauthorized {
            DispatchQueue.main.async {
                // TODO: Handle
            }
        }
    }

    func statusCode(for response: URLResponse) throws -> HTTPStatusCode {
        guard let response = response as? HTTPURLResponse, response.statusCode > 0 else {
            throw Error.noStatusCode
        }

        if let code = HTTPStatusCode(rawValue: response.statusCode) {
            return code
        }

        let category = response.statusCode
        switch category {
        case 300...399:
            return .redirect
        case 400...499:
            return .clientError
        case 500...599:
            return .serverError
        default:
            return .okay
        }
    }

    func decode<D: Decodable>(from data: Data) throws -> D {
        let decodedData = try decoder.decode(D.self, from: data)
        return decodedData
    }
}
