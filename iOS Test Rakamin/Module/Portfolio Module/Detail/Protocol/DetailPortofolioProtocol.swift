//
//  DetailPortofolioProtocol.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 31/03/24.
//

import Foundation

// -MARK: Presenter
protocol DetailPortofolioPresenterToViewProtocol: AnyObject {
    
}

protocol DetailPortofolioPresenterToInteractorProtocol: AnyObject {
    var presenter: DetailPortofolioInteractorToPresenterProtocol? { get set }
}

protocol DetailPortofolioPresenterToRouterProtocol: AnyObject {
    static func createModule(pieModel: [PieModelData]) -> DetailPortofolioViewController
}

// -MARK: View
protocol DetailPortofolioViewToPresenterProtocol: AnyObject {
    var view: DetailPortofolioPresenterToViewProtocol? { get set }
    var interactor: DetailPortofolioPresenterToInteractorProtocol? { get set }
    var router: DetailPortofolioPresenterToRouterProtocol? { get set }
    
    var pieModel: [PieModelData] { get set }
}

// -MARK: Interactor
protocol DetailPortofolioInteractorToPresenterProtocol: AnyObject {
    
}
