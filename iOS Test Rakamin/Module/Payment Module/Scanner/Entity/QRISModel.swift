//
//  QRISModel.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 30/03/24.
//

import Foundation

struct QRISModel {
    let bankName: String
    let transactionID: String
    let merchantName: String
    let amountValue: Int
    
    init(bankName: String, transactionID: String, merchantName: String, amountValue: Int) {
        self.bankName = bankName
        self.transactionID = transactionID
        self.merchantName = merchantName
        self.amountValue = amountValue
    }
}
