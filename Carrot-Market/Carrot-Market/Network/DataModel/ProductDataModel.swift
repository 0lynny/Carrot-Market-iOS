//
//  ProductDataModel.swift
//  Carrot-Market
//
//  Created by 최영린 on 2022/06/04.
//

import Foundation

struct ProductDataModel: Codable {
    let id, title: String
    let region: String
    let image: String?
    let price: Int
    let createdAt: String
}

//extension PostListDataModel{
//    static let sampleData: [PostListDataModel] = [
//        PostListDataModel(productImageName: "productImageName00", productName: "의자", placeName: "경기도 성남시 분당구", price: "15,000원"),
//        PostListDataModel(productImageName: "productImageName01", productName: "테이블", placeName: "경기도 용인시 수지구", price: "32,000원"),
//        PostListDataModel(productImageName: "productImageName02", productName: "노트북", placeName: "경기도 수원시 팔달구", price: "32,000원"),
//        PostListDataModel(productImageName: "productImageName03", productName: "선풍기", placeName: "경기도 수원시 팔달구", price: "32,000원"),
//        PostListDataModel(productImageName: "productImageName00", productName: "데스크탑", placeName: "경기도 수원시 팔달구", price: "32,000원"),
//        PostListDataModel(productImageName: "productImageName01", productName: "귀걸이", placeName: "경기도 수원시 팔달구", price: "32,000원"),
//        PostListDataModel(productImageName: "productImageName02", productName: "노트북", placeName: "경기도 수원시 팔달구", price: "32,000원"),    ]
//}
