//
//  NetworkError.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 31/03/24.
//

import Foundation

enum NetworkError: LocalizedError, Error, Equatable {
    
    case invalidResponse
    case noInternet
    case withStatusCode(Int)
    case addressUnreachable(URL)
    case reason(String)
    case unknownReason
    case empty
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse: return "The server responded with garbage."
        case .noInternet: return "No Internet."
        case .withStatusCode(let statusCode): return HTTPURLResponse.localizedString(forStatusCode:statusCode)
        case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
        case .empty: return ""
        case .unknownReason: return "Error with unknown reason. Please contact mobile dev."
        case .reason(let reason): return reason
        }
    }
}
