//
//  ProductDetailResponseModel.swift
//  Carrot-Market
//
//  Created by 최영린 on 2022/06/13.
//
//
import Foundation

struct ProductDetailResponseModel: Codable {
    let id: String
    let image: [String]
    let user: User
    let onSale, title, category, createdAt: String
    let view, price: Int
    let isPriceSuggestion, isLiked: Bool
}

// MARK: - User
struct User: Codable {
    let profile: String
    let name, region, id: String
    
    enum CodingKeys: String, CodingKey {
        case profile, name, region
        case id = "_id"
    }
}
