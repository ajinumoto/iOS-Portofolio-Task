//
//  PaymentStatusViewControllerTests.swift
//  iOS Test RakaminTests
//
//  Created by Adjie Satryo Pamungkas on 01/04/24.
//

import XCTest
@testable import iOS_Test_Rakamin

final class PaymentStatusViewControllerTests: XCTestCase {

    var sut: PaymentStatusViewController!
    let payment = PaymentEntity(bankName: "TestBank", transactionID: "TestTransactionID", merchantName: "TestMerchant", amountValue: 100, date: Date())

    override func setUpWithError() throws {
        sut = PaymentStatusRouter.createModule(payment)
        sut.loadViewIfNeeded() // Load the view hierarchy
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testDisplayPaymentStatus() throws {
        // Given

        // When
        sut.displayPaymentStatus()

        // Then
        XCTAssertEqual(sut.successLabel.text, "Pembayaran Berhasil")
        XCTAssertEqual(sut.dateLabel.text, "Waktu Transaksi: \(payment.date.withFormat("dd MMMM yyyy HH:mm", locale: "id_ID"))")
        XCTAssertEqual(sut.transactionIDLabel.text, "ID Transaksi: \(payment.transactionID)")
        XCTAssertEqual(sut.merchantNameLabel.text, "Merchant: \(payment.merchantName)")
        XCTAssertEqual(sut.bankNameLabel.text, "Bank: \(payment.bankName)")
        XCTAssertEqual(sut.amountLabel.text, payment.amountValue.toIDR() ?? "Rp0")
    }
}
