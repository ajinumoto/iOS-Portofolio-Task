//
//  HomePortofolioPresenter.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 01/04/24.
//

import Foundation

class HomePortofolioRouterPresenter: HomePortofolioViewToPresenterProtocol {
    
    var interactor: HomePortofolioPresenterToInteractorProtocol?
    var view: HomePortofolioPresenterToViewProtocol?
    var router: HomePortofolioPresenterToRouterProtocol?
    
    var isLoading: Bool = false
    
    func getPortofolio() {
        isLoading = true
        interactor?.getPortofolio()
    }
    
}


extension HomePortofolioRouterPresenter: HomePortofolioInteractorToPresenterProtocol {
    func isSucces(portofolio: [PortofolioModel]) {
        isLoading = false
        view?.succesDelegate(portofolio: portofolio)
    }
}
