//
//  Optional.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 01/04/24.
//

import Foundation

extension Optional where Wrapped == String {
    func toURL() -> URL? {
        // Unwrap the optional string and try to create a URL
        if let urlString = self {
            return URL(string: urlString)
        }
        return nil
    }
}
