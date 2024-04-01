//
//  PaymentStatusProtocol.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 31/03/24.
//

import Foundation

// -MARK: Presenter
protocol PaymentStatusPresenterToViewProtocol: AnyObject {
    
}

protocol PaymentStatusPresenterToInteractorProtocol: AnyObject {
    var presenter: PaymentStatusInteractorToPresenterProtocol? { get set }
}

protocol PaymentStatusPresenterToRouterProtocol: AnyObject {
    static func createModule(_ payment: PaymentEntity?) -> PaymentStatusViewController
}

// -MARK: View
protocol PaymentStatusViewToPresenterProtocol: AnyObject {
    var view: PaymentStatusPresenterToViewProtocol? { get set }
    var interactor: PaymentStatusPresenterToInteractorProtocol? { get set }
    var router: PaymentStatusPresenterToRouterProtocol? { get set }
    var payment: PaymentEntity? { get set }
    
}

// -MARK: Interactor
protocol PaymentStatusInteractorToPresenterProtocol: AnyObject {
    
}
