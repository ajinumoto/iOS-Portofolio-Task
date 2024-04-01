//
//  Date.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 31/03/24.
//

import Foundation

extension Date {
    func withFormat(_ nsDateFormat: String, locale: String? = nil) -> String {
        let dateFormatter = DateFormatter()
        if let locale {
            dateFormatter.locale = Locale(identifier: locale)
        }
        dateFormatter.dateFormat = nsDateFormat
        return dateFormatter.string(from: self)
    }
}
