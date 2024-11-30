//
//  LoginDataModel.swift
//  Pawsitive
//
//  Created by 성호은 on 11/30/24.
//

import Foundation
import Alamofire

// MARK: - Request Body Model
struct LoginRequestBody: Encodable {
    let id: String
    let password: String
}

// MARK: - Response Body Model
struct LoginResponseBody: Decodable {
    let isSuccess: Bool
    let message: String
    let result: LoginResult?
}

// MARK: - Result Model
struct LoginResult: Decodable {
    let id: Int
}
