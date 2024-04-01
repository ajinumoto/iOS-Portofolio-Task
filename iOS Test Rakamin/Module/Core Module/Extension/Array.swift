//
//  Array.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 30/03/24.
//

import Foundation

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
