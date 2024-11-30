//
//  SignupDataModel.swift
//  Pawsitive
//
//  Created by 성호은 on 11/30/24.
//

import Foundation
import Alamofire

// MARK: - Request Body Model
struct SignupRequestBody: Encodable {
    let id: String
    let password: String
    let name: String
    let birth: String
    let phone: String
}

// MARK: - Response Body Model
struct SignupResponseBody: Decodable {
    let isSuccess: Bool
    let message: String
    let result: SignupResult
}

struct SignupResult: Decodable {
    let id: Int
}
