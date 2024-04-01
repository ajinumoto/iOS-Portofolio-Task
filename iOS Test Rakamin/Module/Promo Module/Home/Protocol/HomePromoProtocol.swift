//
//  HomePromoProtocol.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 31/03/24.
//

import Foundation

// -MARK: Presenter
protocol HomePromoPresenterToViewProtocol: AnyObject {
    func succesDelegate(promo: PromoResponse)
    func errorDelegate()
    func loadingStateHasChanged(isLoading: Bool)
}

protocol HomePromoPresenterToInteractorProtocol: AnyObject {
    var presenter: HomePromoInteractorToPresenterProtocol? { get set }
    
    func getPromos()
}

protocol HomePromoPresenterToRouterProtocol: AnyObject {
    static func createModule() -> HomePromoViewController
}

// -MARK: View
protocol HomePromoViewToPresenterProtocol: AnyObject {
    var view: HomePromoPresenterToViewProtocol? { get set }
    var interactor: HomePromoPresenterToInteractorProtocol? { get set }
    var router: HomePromoPresenterToRouterProtocol? { get set }
    
    func getPromos()
    
}

// -MARK: Interactor
protocol HomePromoInteractorToPresenterProtocol: AnyObject {
    
    func isSucces(promo: PromoResponse)
    func isFailed()
}
