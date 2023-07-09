//
//  DetailCafeMenuService.swift
//  CaZait-iOS
//
//  Created by J on 2023/06/02.
//

import Foundation
import Alamofire

class DetailCafeMenuService{
    func getDetailCafeMenuBycafeID(cafeID: Int, completion: @escaping (Result<[DetailCafeMenu], Error>) -> Void) {
        let url = APIConstants.detailCafeMenuURL + "/\(cafeID)"
        
        AF.request(url)
            .validate()
            .responseDecodable(of: DetailCafeMenuResponse.self) { response in
                switch response.result {
                case .success(let cafeResponse):
                    if cafeResponse.result == "SUCCESS" {
                        completion(.success(cafeResponse.data))
                    } else {
                        let error = NSError(domain: "API Error", code: 0, userInfo: [NSLocalizedDescriptionKey: cafeResponse.message])
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }

}
