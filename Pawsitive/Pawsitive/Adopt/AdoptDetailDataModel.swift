//
//  AdoptDetailDataModel.swift
//  Pawsitive
//
//  Created by 성호은 on 11/30/24.
//

import Foundation
import Alamofire

// MARK: - Response Body
struct AdoptionDetailResponse: Decodable {
    let isSuccess: Bool
    let message: String
    let result: AdoptionDetail?
}

struct AdoptionDetail: Decodable {
    let id: Int
    let title: String
    let status: String
    let type: String
    let specType: String
    let gender: String
    let neutering: Bool
    let age: String
    let description: String
    let shelterName: String
    let createdAt: String
    let mangerName: String
    let phone: String
}
