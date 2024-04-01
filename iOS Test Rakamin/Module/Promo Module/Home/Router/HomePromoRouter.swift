//
//  HomePromoRouter.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 31/03/24.
//

import Foundation

class HomePromoRouter: HomePromoPresenterToRouterProtocol {
    static func createModule() -> HomePromoViewController {
        let view: HomePromoPresenterToViewProtocol & HomePromoViewController = HomePromoViewController()
        let interactor: HomePromoPresenterToInteractorProtocol = HomePromoInteractor()
        let presenter: HomePromoViewToPresenterProtocol & HomePromoInteractorToPresenterProtocol = HomePromoPresenter()
        let router: HomePromoPresenterToRouterProtocol = HomePromoRouter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        return view
    }
}
