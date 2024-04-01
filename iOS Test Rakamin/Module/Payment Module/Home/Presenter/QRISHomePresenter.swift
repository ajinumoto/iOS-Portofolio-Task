//
//  QRISPresenter.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 30/03/24.
//

import Foundation

// MARK: - Presenter
class QRISHomePresenter: QRISHomeViewToPresenterProtocol, QRISHomeInteractorToPresenterProtocol {
    var interactor: QRISHomePresenterToInteractorProtocol?
    var view: QRISHomePresenterToViewProtocol?
    var router: QRISHomePresenterToRouterProtocol?
}
