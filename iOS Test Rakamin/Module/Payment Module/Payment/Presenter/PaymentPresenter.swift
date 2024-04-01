//
//  PaymentPresenter.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 31/03/24.
//

import Foundation

class PaymentPresenter: PaymentViewToPresenterProtocol, PaymentInteractorToPresenterProtocol {
    var interactor: PaymentPresenterToInteractorProtocol?
    var view: PaymentPresenterToViewProtocol?
    var router: PaymentPresenterToRouterProtocol?
    
    var qris: QRISModel?
}
