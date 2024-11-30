//
//  AdoptDataModel.swift
//  Pawsitive
//
//  Created by 성호은 on 11/30/24.
//

import Foundation
import Alamofire

// MARK: - Response Body
struct AdoptionResponse: Decodable {
    let isSuccess: Bool
    let message: String
    let result: AdoptionResult
}

struct AdoptionResult: Decodable {
    let adoptions: [AdoptionItem]
}

struct AdoptionItem: Decodable {
    let id: Int
    let title: String
    let type: String
    let specType: String
    let shelterName: String
    let createdAt: String
}
