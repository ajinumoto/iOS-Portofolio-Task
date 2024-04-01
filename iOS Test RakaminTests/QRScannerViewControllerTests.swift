//
//  QRScannerViewControllerTests.swift
//  iOS Test RakaminTests
//
//  Created by Adjie Satryo Pamungkas on 01/04/24.
//

import XCTest
@testable import iOS_Test_Rakamin

final class QRScannerViewControllerTests: XCTestCase {

    var viewController: QRScannerViewController!

    override func setUpWithError() throws {
        viewController = QRScannerRouter.createModule()
        viewController.loadViewIfNeeded() // Load the view hierarchy
    }

    override func tearDownWithError() throws {
        viewController = nil
    }

    func testViewDidLoad() throws {
        // Given
        let expectedTitle = "Pindai QRIS"
        let expectedBackgroundColor = UIColor.white

        // When
        let title = viewController.title
        let backgroundColor = viewController.view.backgroundColor

        // Then
        XCTAssertEqual(title, expectedTitle, "Title is incorrect")
        XCTAssertEqual(backgroundColor, expectedBackgroundColor, "Background color is incorrect")
    }
}
