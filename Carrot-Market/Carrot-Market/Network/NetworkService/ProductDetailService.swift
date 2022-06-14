//
//  ProductDetailService.swift
//  Carrot-Market
//
//  Created by 최영린 on 2022/06/13.
//

import Foundation
import Alamofire

struct ProductDetailService {
    static let shared = ProductDetailService()
    private init() {}
    
    func getProductDetail(dataModel : ProductDetailRequestModel, completion: @escaping (NetworkResult<Any>) -> (Void))
    {
        let url = URLConstant.productDetail + "\(dataModel.id)"
        let header: HTTPHeaders = NetworkConstant.noTokenHeader
        let dataRequest = AF.request(url,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let value = response.value else { return }
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    private func judgeStatus (by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        print(statusCode)
        switch statusCode {
        case 200: return isValidProductDetailURL(data: data)
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func isValidProductDetailURL(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<ProductDetailResponseModel>.self, from: data)
//        guard let decodedData = try? decoder.decode(ProductDetailResponseModel.self, from: data)
        else { return .pathErr }
        
        return .success(decodedData.data as Any)
    }
}

