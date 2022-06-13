//
//  URLConstant.swift
//  Carrot-Market
//
//  Created by 최영린 on 2022/06/01.
//

import Foundation

struct URLConstant {
    static let baseURL = "http://13.125.157.62:8000"
    
    static let productList = baseURL + "/feed"
    static let productDetail = baseURL + "/feed/"
    static let productLike = baseURL + "/feed/like/"
    static let productStatus = baseURL + "/feed/on-sale"
}


