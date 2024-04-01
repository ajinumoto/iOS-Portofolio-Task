//
//  HomePortofolioProtocol.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 01/04/24.
//

import Foundation

// -MARK: Presenter
protocol HomePortofolioPresenterToViewProtocol: AnyObject {
    func succesDelegate(portofolio: [PortofolioModel])
}

protocol HomePortofolioPresenterToInteractorProtocol: AnyObject {
    var presenter: HomePortofolioInteractorToPresenterProtocol? { get set }
    
    func getPortofolio()
}

protocol HomePortofolioPresenterToRouterProtocol: AnyObject {
    static func createModule() -> HomePortofolioViewController
}

// -MARK: View
protocol HomePortofolioViewToPresenterProtocol: AnyObject {
    var view: HomePortofolioPresenterToViewProtocol? { get set }
    var interactor: HomePortofolioPresenterToInteractorProtocol? { get set }
    var router: HomePortofolioPresenterToRouterProtocol? { get set }
    
    func getPortofolio()
    
}

// -MARK: Interactor
protocol HomePortofolioInteractorToPresenterProtocol: AnyObject {
    
    func isSucces(portofolio: [PortofolioModel])
}
