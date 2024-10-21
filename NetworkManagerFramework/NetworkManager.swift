//
//  NetworkManager.swift
//  Network Manager
//
//  Created by Sphoorti Patil on 19/10/24.
//

import Foundation

public class NetworkManager {
    
    public static let shared = NetworkManager()
    private let UrlSession = URLSession.shared
    
    init() {
        //
    }
    
    public func fetchApiData<T: Codable> (from apiRequest: APIRequest, completionHandler: @escaping(Result<T, APIRequestError>) -> Void) {
        do {
            let urlRequest = try apiRequest.getURLRequest()
            handleNetworkRequest(from: urlRequest, completionHandler: completionHandler)
        } catch {
            completionHandler(.failure(error as? APIRequestError ?? .responseFailed(error)))
        }
    }
    
    private func handleNetworkRequest<T: Codable> (from urlRequest: URLRequest, completionHandler: @escaping(Result<T, APIRequestError>) -> Void) {
        UrlSession.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completionHandler(.failure(.responseFailed(error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse, validateResponse(response) != nil, let data = data else {
                completionHandler(.failure(.invalidResponse))
                return
            }
 
            let decoder = JSONDecoder()
            do{
                let decodedData = try decoder.decode(T.self, from: data)
                completionHandler(.success(decodedData))
            } catch {
                completionHandler(.failure(.decodingFailed))
            }
            
        }.resume()
    }
}
