//
//  QRScannerPresenter.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 30/03/24.
//

import Foundation

class QRScannerPresenter: QRScannerViewToPresenterProtocol, QRScannerInteractorToPresenterProtocol {
    var interactor: QRScannerPresenterToInteractorProtocol?
    var view: QRScannerPresenterToViewProtocol?
    var router: QRScannerPresenterToRouterProtocol?
}
