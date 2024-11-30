//
//  VolunteerDetailDataModel.swift
//  Pawsitive
//
//  Created by 성호은 on 11/30/24.
//

import Foundation
import Alamofire

struct VolunteerDetailResponse: Decodable {
    let isSuccess: Bool
    let message: String
    let result: VolunteerDetail
}

struct VolunteerDetail: Decodable {
    let id: Int
    let title: String
    let volunteerDate: String
    let numberOfStaffs: Int
    let status: String
    let region: String
    let startTime: String
    let endTime: String
    let content: String
    let managerName: String
    let phone: String
    let shelterName: String
    let address: String
}
