//
//  PaymentStatusRouter.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 31/03/24.
//

import Foundation

class PaymentStatusRouter: PaymentStatusPresenterToRouterProtocol {
    
    static func createModule(_ payment: PaymentEntity?) -> PaymentStatusViewController {
        let view: PaymentStatusPresenterToViewProtocol & PaymentStatusViewController = PaymentStatusViewController()
        let interactor: PaymentStatusPresenterToInteractorProtocol = PaymentStatusInteractor()
        let presenter: PaymentStatusViewToPresenterProtocol & PaymentStatusInteractorToPresenterProtocol = PaymentStatusPresenter()
        let router: PaymentStatusPresenterToRouterProtocol = PaymentStatusRouter()
        
        presenter.payment = payment
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        return view
    }
}
