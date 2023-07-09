//
//  DetailCafeMenuModel.swift
//  CaZait-iOS
//
//  Created by J on 2023/06/02.
//

import Foundation

struct DetailCafeMenuResponse: Codable {
    let code: Int
    let result: String
    let message: String
    let data: [DetailCafeMenu]
}

struct DetailCafeMenu: Codable {
    let cafeMenuId: Int
    let name: String
    let description: String
    let price: Int
    let imageUrl: String
}
