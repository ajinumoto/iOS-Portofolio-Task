//
//  HomePromoPresenter.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 31/03/24.
//

import Foundation

class HomePromoPresenter: HomePromoViewToPresenterProtocol {
    
    var interactor: HomePromoPresenterToInteractorProtocol?
    var view: HomePromoPresenterToViewProtocol?
    var router: HomePromoPresenterToRouterProtocol?
    
    var isLoading: Bool = false {
        didSet {
            view?.loadingStateHasChanged(isLoading: isLoading)
        }
    }
    
    func getPromos() {
        isLoading = true
        interactor?.getPromos()
    }
    
}


extension HomePromoPresenter: HomePromoInteractorToPresenterProtocol {
    
    func isSucces(promo: PromoResponse) {
        isLoading = false
        view?.succesDelegate(promo: promo)
    }
    
    func isFailed() {
        isLoading = false
        view?.errorDelegate()
    }
}
