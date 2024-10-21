//
//  APIResponseValidator.swift
//  Network Manager
//
//  Created by Sphoorti Patil on 20/10/24.
//

import Foundation

public func validateResponse(_ response: HTTPURLResponse) -> Bool? {
    switch response.statusCode {
    case 200...299:
        return true
    case 400...499:
        return nil
    case 500...599:
        return nil
    default:
        return nil
    }
}
