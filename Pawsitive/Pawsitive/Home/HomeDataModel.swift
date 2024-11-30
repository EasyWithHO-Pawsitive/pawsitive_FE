//
//  HomeDataModel.swift
//  Pawsitive
//
//  Created by 성호은 on 11/30/24.
//

import Foundation
import Alamofire

// MARK: - Response Body Model
struct VolunteerAdoptionResponse: Decodable {
    let isSuccess: Bool
    let message: String
    let result: VolunteerAdoptionResult
}

struct VolunteerAdoptionResult: Decodable {
    let volunteers: [Volunteer]
    let adoptions: [Adoption]
}

struct Volunteer: Decodable {
    let id: Int
    let region: String
    let title: String
}

struct Adoption: Decodable {
    let id: Int
    let type: String
    let specType: String
    let shelterName: String
    let createdAt: String
}
