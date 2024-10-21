//
//  APIRequestError.swift
//  Network Manager
//
//  Created by Sphoorti Patil on 19/10/24.
//

import Foundation

public enum APIRequestError: Error {
    case invalidURL
    case invalidResponse
    case decodingFailed
    case serilizationFailed
    case noInternetConnectivity
    case responseFailed(Error)
    case clientError(Int)
    case unknownError(Int)
    case serverError(Int)
}

extension APIRequestError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response received from the server."
        case .decodingFailed:
            return "Failed to decode the response data."
        case .serilizationFailed:
            return "Error serializing JSON when making API Call."
        case .noInternetConnectivity:
            return "No Internet Conenction."
        case .responseFailed(let error):
            return "Failed to get respone \(error)"
        case .clientError(let statusCode):
                    return "Client error occurred. Status code: \(statusCode)"
        case .serverError(let statusCode):
            return "Server error occurred. Status code: \(statusCode)"
        case .unknownError(let statusCode):
            return "An unknown error occurred. Status code: \(statusCode)"
        }
    }
}
