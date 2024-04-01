//
//  PaymentEntity.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 31/03/24.
//

import Foundation

struct PaymentEntity: Codable {
    let bankName: String
    let transactionID: String
    let merchantName: String
    let amountValue: Int
    let date: Date
    
    init(bankName: String, transactionID: String, merchantName: String, amountValue: Int, date: Date) {
        self.bankName = bankName
        self.transactionID = transactionID
        self.merchantName = merchantName
        self.amountValue = amountValue
        self.date = date
    }
}
