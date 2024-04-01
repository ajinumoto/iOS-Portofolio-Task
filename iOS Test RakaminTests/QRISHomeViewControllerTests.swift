//
//  QRISHomeViewControllerTests.swift
//  iOS Test RakaminTests
//
//  Created by Adjie Satryo Pamungkas on 01/04/24.
//

import XCTest
@testable import iOS_Test_Rakamin

final class QRISHomeViewControllerTests: XCTestCase {
    
    var sut: QRISHomeViewController!
    
    override func setUp() {
        super.setUp()
        sut = QRISHomeRouter.createModule()
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testInitialBalanceLabelText() throws {
           // Given

           // When
            let balanceText = sut.balanceLabel.text
           // Then
           XCTAssertNil(balanceText, "Initial balance label text is incorrect")
       }

       func testUpdateBalanceLabel() throws {
           // Given
           let newBalance: Int = 600_000
           let expectedUpdatedBalanceText = Constants.balanceLabelPrefix + (newBalance.toIDR() ?? "")

           // When
           UserDefaults.standard.set(newBalance, forKey: Constants.initialBalanceKey)
           sut.updateBalance()
           let balanceText = sut.balanceLabel.text

           // Then
           XCTAssertEqual(balanceText, expectedUpdatedBalanceText, "Updated balance label text is incorrect")
       }
}
