//
//  VolunteerApplyDataModel.swift
//  Pawsitive
//
//  Created by 성호은 on 11/30/24.
//

import Foundation
import Alamofire

// MARK: - Request Body
struct VolunteerApplyRequest: Encodable {
    let id: Int
    let postId: Int
}

// MARK: - Response Body
struct VolunteerApplyResponse: Decodable {
    let isSuccess: Bool
    let message: String
    let result: VolunteerApplyResult?
}

struct VolunteerApplyResult: Decodable {
    let id: Int
}
