//
//  HistoryProtocol.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 31/03/24.
//

import Foundation

// -MARK: Presenter
protocol HistoryPresenterToViewProtocol: AnyObject {
    
}

protocol HistoryPresenterToInteractorProtocol: AnyObject {
    var presenter: HistoryInteractorToPresenterProtocol? { get set }
}

protocol HistoryPresenterToRouterProtocol: AnyObject {
    static func createModule() -> HistoryViewController
}

// -MARK: View
protocol HistoryViewToPresenterProtocol: AnyObject {
    var view: HistoryPresenterToViewProtocol? { get set }
    var interactor: HistoryPresenterToInteractorProtocol? { get set }
    var router: HistoryPresenterToRouterProtocol? { get set }
    
}

// -MARK: Interactor
protocol HistoryInteractorToPresenterProtocol: AnyObject {
    
}
