//
//  APIRequest.swift
//  Network Manager
//
//  Created by Sphoorti Patil on 19/10/24.
//

import Foundation

public protocol APIRequest {
    var url : String { get }
    var httpMethod: HTTPRequestMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: Any]? { get set }
}

extension APIRequest {
    func getURLRequest() throws -> URLRequest {
        guard let url = URL(string: url) else {
            throw APIRequestError.invalidURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        if let parameters = parameters {
            if httpMethod == .get {
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                components?.queryItems = parameters.map{ URLQueryItem(name: $0.key, value: "\($0.value)")}
                urlRequest.url = components?.url
            } else {
                do {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters)
                } catch {
                    throw APIRequestError.serilizationFailed
                }
            }
        }
        return urlRequest
    }
}
