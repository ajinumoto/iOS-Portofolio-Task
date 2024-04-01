//
//  HomePortofolioInteractor.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 01/04/24.
//

import Foundation

class HomePortofolioRouterInteractor: HomePortofolioPresenterToInteractorProtocol {
    
    var presenter: HomePortofolioInteractorToPresenterProtocol?
    
    func getPortofolio() {
        let jsonString = PortofolioProvider.mockData
        
        guard let jsonData = jsonString.data(using: .utf8) else {
            return
        }
        
        do {
            let portofolio = try JSONDecoder().decode([PortofolioModel].self, from: jsonData)
            presenter?.isSucces(portofolio: portofolio)
            return
        } catch {
            print("Error decoding JSON: \(error)")
            return
        }
    }
}
