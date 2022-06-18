//
//  ProductDataModel.swift
//  Carrot-Market
//
//  Created by 최영린 on 2022/06/04.
//

import Foundation

struct ProductListResponseModel: Codable {
    let id, title: String
    let region: String
    let image: String?
    let price: Int
    let createdAt: String
}

