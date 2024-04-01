//
//  Int.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 30/03/24.
//

import Foundation

extension Int {
    func toIDR() -> String? {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "id_ID")
        
        return formatter.string(from: self as NSNumber)
        
    }
}
