//
//  Endpoint.swift
//  CarrotClone
//
//  Created by 한상진 on 2021/07/20.
//

import Foundation

// MARK: Constant

typealias HTTPHeaders = [String: String]
typealias Parameters = [String: Any?]

enum HTTPHeaderFields {
    static let contentType: String = "Content-Type"
    static let json: String = "application/json"
}

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE" 
}

enum HTTPTask {
    case none
    case requestHeader(urlParams: Parameters?)
    case requestBody(body: Any?)
}

enum NetworkError: Error {
    case noSelf
    case urlToUrlRequest
    case dataTask
    case responseCasting
    case invalidStatus
    case noData
    case unableToDecode
    case invalidErrorCode
}

// MARK: Protocol

protocol EndpointType {
    var baseURL: URL { get }
    var path: String? { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
    func asURLRequest() throws -> URLRequest
}

// MARK: Endpoint

enum Endpoint {
    case readCarrots
}

extension Endpoint: EndpointType {
    var baseURL: URL {
        guard let baseURL = URL(string: "http://carrot.mock.com") else { fatalError("잘못된 baseURL") }
        return baseURL
    }
    
    var path: String? {
        switch self {
        case .readCarrots:
            return "/some/path/"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .readCarrots:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .readCarrots:
            return .none
        }
    }
    
    var headers: HTTPHeaders? {
        return [
            HTTPHeaderFields.contentType: HTTPHeaderFields.json
        ]
    }
    
    func asURLRequest() throws -> URLRequest {
        var url: URL = self.baseURL
        
        url.appendPathComponent(self.path ?? "")
        
        var request: URLRequest = .init(url: url)
        
        request.httpMethod = self.httpMethod.rawValue
        request.allHTTPHeaderFields = self.headers
        
        switch self.task {
        case .none:
            break // try encode
        case .requestHeader(_):
            break // try encode
        case .requestBody(_):
            break
        }
        
        return request
    }
}
