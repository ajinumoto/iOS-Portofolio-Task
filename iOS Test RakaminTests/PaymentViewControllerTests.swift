//
//  PaymentViewControllerTests.swift
//  iOS Test RakaminTests
//
//  Created by Adjie Satryo Pamungkas on 01/04/24.
//

import XCTest
@testable import iOS_Test_Rakamin

final class PaymentViewControllerTests: XCTestCase {

    var viewController: PaymentViewController!

    override func setUpWithError() throws {
        let mockQRIS = QRISModel(bankName: "TestBank", transactionID: "TestTransactionID", merchantName: "TestMerchant", amountValue: 100)
        viewController = PaymentRouter.createModule(mockQRIS)
        viewController.loadViewIfNeeded() // Load the view hierarchy
    }

    override func tearDownWithError() throws {
        viewController = nil
    }

    func testDisplayPaymentDetails() throws {
        // Given

        // When
        viewController.displayPaymentDetails()

        // Then
        XCTAssertEqual(viewController.transactionIDLabel.text, "ID Transaksi: TestTransactionID")
        XCTAssertEqual(viewController.merchantNameLabel.text, "Merchant: TestMerchant")
        XCTAssertEqual(viewController.amountLabel.text, "Rp100")
    }
    

}
