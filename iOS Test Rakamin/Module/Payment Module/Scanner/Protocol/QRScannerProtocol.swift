//
//  QRScannerProtocol.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 30/03/24.
//

import Foundation

// -MARK: Presenter
protocol QRScannerPresenterToViewProtocol: AnyObject {
    
}

protocol QRScannerPresenterToInteractorProtocol: AnyObject {
    var presenter: QRScannerInteractorToPresenterProtocol? { get set }
}

protocol QRScannerPresenterToRouterProtocol: AnyObject {
    static func createModule() -> QRScannerViewController
}

// -MARK: View
protocol QRScannerViewToPresenterProtocol: AnyObject {
    var view: QRScannerPresenterToViewProtocol? { get set }
    var interactor: QRScannerPresenterToInteractorProtocol? { get set }
    var router: QRScannerPresenterToRouterProtocol? { get set }
}

// -MARK: Interactor
protocol QRScannerInteractorToPresenterProtocol: AnyObject {
    
}
