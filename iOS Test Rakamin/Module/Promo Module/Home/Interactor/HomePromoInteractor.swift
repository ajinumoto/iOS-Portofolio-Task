//
//  HomePromoInteractor.swift
//  iOS Test Rakamin
//
//  Created by Adjie Satryo Pamungkas on 31/03/24.
//

import Foundation
import Alamofire

class HomePromoInteractor: HomePromoPresenterToInteractorProtocol {
    var presenter: HomePromoInteractorToPresenterProtocol?
    
    func getPromos() {
        let components = URLComponents(string: Endpoints.Gets.promos.url)
        let interceptor = AuthorizationInterceptor()
        
        let headers: HTTPHeaders = [
            .contentType("application/json"),
        ]
        
        if let url = components?.url {
            AF.request(url, method: .get, headers: headers, interceptor: interceptor)
                .responseDecodable(of: PromoResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        self.presenter?.isSucces(promo: value)
                    case .failure:
                        self.presenter?.isFailed()
                    }
                }
        }
    }
}
