//
//  VolunteerRegisterDataModel.swift
//  Pawsitive
//
//  Created by 성호은 on 11/30/24.
//

import Foundation
import Alamofire

struct VolunteerPostRequest: Encodable {
    let shelterId: Int
    let title: String
    let volunteerDate: String
    let numberOfStaffs: Int
    let startTime: String
    let endTime: String
    let content: String
}

struct VolunteerPostResponse: Decodable {
    let isSuccess: Bool
    let message: String
    let result: VolunteerPostResult?
}

struct VolunteerPostResult: Decodable {
    let id: Int
}
