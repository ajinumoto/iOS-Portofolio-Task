//
//  QRISHomeRouter.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 30/03/24.
//

import Foundation

class QRISHomeRouter: QRISHomePresenterToRouterProtocol {
    static func createModule() -> QRISHomeViewController {
        let view: QRISHomePresenterToViewProtocol & QRISHomeViewController = QRISHomeViewController()
        let interactor: QRISHomePresenterToInteractorProtocol = QRISHomeInteractor()
        let presenter: QRISHomeViewToPresenterProtocol & QRISHomeInteractorToPresenterProtocol = QRISHomePresenter()
        let router: QRISHomePresenterToRouterProtocol = QRISHomeRouter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        return view
    }
}
