//
//  QRScannerRouter.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 30/03/24.
//

import Foundation

class QRScannerRouter: QRScannerPresenterToRouterProtocol {
    static func createModule() -> QRScannerViewController {
        let view: QRScannerPresenterToViewProtocol & QRScannerViewController = QRScannerViewController()
        let interactor: QRScannerPresenterToInteractorProtocol = QRScannerInteractor()
        let presenter: QRScannerViewToPresenterProtocol & QRScannerInteractorToPresenterProtocol = QRScannerPresenter()
        let router: QRScannerPresenterToRouterProtocol = QRScannerRouter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        return view
    }
}
