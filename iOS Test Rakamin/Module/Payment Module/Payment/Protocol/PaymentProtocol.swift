//
//  PaymentProtocol.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 31/03/24.
//

import Foundation

// -MARK: Presenter
protocol PaymentPresenterToViewProtocol: AnyObject {
    
}

protocol PaymentPresenterToInteractorProtocol: AnyObject {
    var presenter: PaymentInteractorToPresenterProtocol? { get set }
}

protocol PaymentPresenterToRouterProtocol: AnyObject {
    static func createModule(_ qris: QRISModel?) -> PaymentViewController
}

// -MARK: View
protocol PaymentViewToPresenterProtocol: AnyObject {
    var view: PaymentPresenterToViewProtocol? { get set }
    var interactor: PaymentPresenterToInteractorProtocol? { get set }
    var router: PaymentPresenterToRouterProtocol? { get set }
    var qris: QRISModel? { get set }
    
}

// -MARK: Interactor
protocol PaymentInteractorToPresenterProtocol: AnyObject {
    
}
