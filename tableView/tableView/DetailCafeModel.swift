//
//  DetailCafeModel.swift
//  CaZait-iOS
//
//  Created by J on 2023/06/02.
//

import Foundation

struct DetailCafeResponse: Codable {
    let code: Int
    let result: String
    let message: String
    let data: DetailCafe
}

struct DetailCafe: Codable {
    let cafeId: Int
    let congestionStatus: String
    let name: String
    let address: String
    let longitude: String
    let latitude: String
    let getCafeImageRes: [DetailCafeImage]
    let logResult: String?
}

struct DetailCafeImage: Codable {
    let cafeImageId: Int
    let imageUrl: String
}
