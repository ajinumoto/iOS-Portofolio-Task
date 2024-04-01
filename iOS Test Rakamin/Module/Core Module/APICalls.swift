//
//  APICalls.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 31/03/24.
//

import Foundation

struct API {
    
    static let baseURL = "https://demo5853970.mockable.io"
    
}

protocol Endpoint {
    
    var url: String { get }
    
}

enum Endpoints {
    
    enum Gets: Endpoint {
        case promos
        
        public var url: String {
            switch self {
            case .promos: return "\(API.baseURL)/promos"
            }
        }
    }
}
