//
//  API+Extension.swift
//  Pawsitive
//
//  Created by 성호은 on 11/30/24.
//

import Foundation
import Alamofire

// MARK: - APIClient 클래스 정의
class APIClient {
    static let shared = APIClient()
    private init() {}
}

extension APIClient {
    // Base URL 설정
    private static let baseURL = "http://localhost:8080"
    
    // 공통 헤더 생성 함수 (토큰 제거)
    private static func getHeaders() -> HTTPHeaders {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    // GET 요청 함수
    static func getRequest<T: Decodable>(endpoint: String, parameters: [String: Any]? = nil, completion: @escaping (Result<T, AFError>) -> Void) {
        let url = "\(baseURL)\(endpoint)"
        let headers = getHeaders()
        
        AF.request(url, method: .get, parameters: parameters, headers: headers).responseDecodable(of: T.self) { response in
            completion(response.result)
        }
    }
    
    // POST 요청 함수
    static func postRequest<T: Decodable, U: Encodable>(endpoint: String, parameters: U, completion: @escaping (Result<T, AFError>) -> Void) {
        let url = "\(baseURL)\(endpoint)"
        let headers = getHeaders()
        
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: T.self) { response in
            if let data = response.data {
                print("Raw Response Data: \(String(data: data, encoding: .utf8) ?? "Invalid data")")
            }
            completion(response.result)
        }
    }
}
