//
//  DetailPortofolioViewController.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 31/03/24.
//

import Foundation

class DetailPortofolioRouter: DetailPortofolioPresenterToRouterProtocol {
    
    static func createModule(pieModel: [PieModelData]) -> DetailPortofolioViewController {
        let view: DetailPortofolioPresenterToViewProtocol & DetailPortofolioViewController = DetailPortofolioViewController()
        let interactor: DetailPortofolioPresenterToInteractorProtocol = DetailPortofolioInteractor()
        let presenter: DetailPortofolioViewToPresenterProtocol & DetailPortofolioInteractorToPresenterProtocol = DetailPortofolioPresenter()
        let router: DetailPortofolioPresenterToRouterProtocol = DetailPortofolioRouter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.pieModel = pieModel
        presenter.router = router
        presenter.interactor = interactor
        
        return view
    }
}
