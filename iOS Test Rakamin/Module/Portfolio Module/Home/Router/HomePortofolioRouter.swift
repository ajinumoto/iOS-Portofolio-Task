//
//  HomePortofolioRouter.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 01/04/24.
//

import Foundation

class HomePortofolioRouter: HomePortofolioPresenterToRouterProtocol {
    static func createModule() -> HomePortofolioViewController {
        let view: HomePortofolioPresenterToViewProtocol & HomePortofolioViewController = HomePortofolioViewController()
        let interactor: HomePortofolioPresenterToInteractorProtocol = HomePortofolioRouterInteractor()
        let presenter: HomePortofolioViewToPresenterProtocol & HomePortofolioInteractorToPresenterProtocol = HomePortofolioRouterPresenter()
        let router: HomePortofolioPresenterToRouterProtocol = HomePortofolioRouter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        return view
    }
}
