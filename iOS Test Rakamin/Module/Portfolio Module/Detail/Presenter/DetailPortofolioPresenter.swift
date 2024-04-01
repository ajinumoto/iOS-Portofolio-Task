//
//  DetailPortofolioPresenter.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 31/03/24.
//

import Foundation

class DetailPortofolioPresenter: DetailPortofolioViewToPresenterProtocol, DetailPortofolioInteractorToPresenterProtocol {
    var interactor: DetailPortofolioPresenterToInteractorProtocol?
    var view: DetailPortofolioPresenterToViewProtocol?
    var router: DetailPortofolioPresenterToRouterProtocol?
    
    var pieModel: [PieModelData] = []
    
}
