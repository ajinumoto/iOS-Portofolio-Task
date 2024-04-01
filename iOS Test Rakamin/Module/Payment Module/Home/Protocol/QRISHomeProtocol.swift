//
//  QRISHomeProtocol.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 30/03/24.
//

import Foundation

// MARK: - Presenter Protocols
protocol QRISHomePresenterToViewProtocol: AnyObject {}

protocol QRISHomePresenterToInteractorProtocol: AnyObject {
    var presenter: QRISHomeInteractorToPresenterProtocol? { get set }
}

protocol QRISHomePresenterToRouterProtocol: AnyObject {
    static func createModule() -> QRISHomeViewController
}

// MARK: - View Protocols
protocol QRISHomeViewToPresenterProtocol: AnyObject {
    var view: QRISHomePresenterToViewProtocol? { get set }
    var interactor: QRISHomePresenterToInteractorProtocol? { get set }
    var router: QRISHomePresenterToRouterProtocol? { get set }
}

// MARK: - Interactor Protocols
protocol QRISHomeInteractorToPresenterProtocol: AnyObject {}

