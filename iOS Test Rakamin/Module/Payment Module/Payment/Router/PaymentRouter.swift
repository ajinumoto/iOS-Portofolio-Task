//
//  PaymentRouter.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 31/03/24.
//

import Foundation

class PaymentRouter: PaymentPresenterToRouterProtocol {
    static func createModule(_ qris: QRISModel?) -> PaymentViewController {
        let view: PaymentPresenterToViewProtocol & PaymentViewController = PaymentViewController()
        let interactor: PaymentPresenterToInteractorProtocol = PaymentInteractor()
        let presenter: PaymentViewToPresenterProtocol & PaymentInteractorToPresenterProtocol = PaymentPresenter()
        let router: PaymentPresenterToRouterProtocol = PaymentRouter()
        
        presenter.qris = qris
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        return view
    }
}
