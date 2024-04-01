//
//  PromoResponse.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 31/03/24.
//

import Foundation

struct PromoResponse: Codable {
    let promos: [Promo]?
}

struct Promo: Codable {
    let id: Int?
    let name: String?
    let imagesURL: String?
    let detail: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case imagesURL = "images_url"
        case detail
    }
}
