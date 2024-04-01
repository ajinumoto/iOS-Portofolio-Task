//
//  HistoryRouter.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 31/03/24.
//

import Foundation

class HistoryRouter: HistoryPresenterToRouterProtocol {
    static func createModule() -> HistoryViewController {
        let view: HistoryPresenterToViewProtocol & HistoryViewController = HistoryViewController()
        let interactor: HistoryPresenterToInteractorProtocol = HistoryInteractor()
        let presenter: HistoryViewToPresenterProtocol & HistoryInteractorToPresenterProtocol = HistoryPresenter()
        let router: HistoryPresenterToRouterProtocol = HistoryRouter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        return view
    }
}
