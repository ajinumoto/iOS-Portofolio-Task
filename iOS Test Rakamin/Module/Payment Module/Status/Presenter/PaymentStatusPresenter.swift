//
//  PaymentStatusPresenter.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 31/03/24.
//

import Foundation

class PaymentStatusPresenter: PaymentStatusViewToPresenterProtocol, PaymentStatusInteractorToPresenterProtocol {
    var interactor: PaymentStatusPresenterToInteractorProtocol?
    var view: PaymentStatusPresenterToViewProtocol?
    var router: PaymentStatusPresenterToRouterProtocol?
    
    var payment: PaymentEntity?
}
