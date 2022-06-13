//
//  productService.swift
//  Carrot-Market
//
//  Created by 최영린 on 2022/06/04.
//
import Foundation
import Alamofire

struct ProductListService {
    static let shared = ProductListService()
    private init() {}
    
    func getProductList(completion: @escaping (NetworkResult<Any>) -> (Void))
    {
        let url = URLConstant.productList
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
        case 200: return isValidProductListURL(data: data)
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    private func isValidProductListURL(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<[ProductDataModel]>.self, from: data)
        else { return .pathErr }
        
        return .success(decodedData.data as Any)
    }
}
