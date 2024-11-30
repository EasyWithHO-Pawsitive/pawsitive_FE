//
//  VolunteerListDataModel.swift
//  Pawsitive
//
//  Created by 성호은 on 11/30/24.
//

import Foundation

// MARK: - Response Body Model
struct VolunteerResponse: Decodable {
    let isSuccess: Bool
    let message: String
    let result: VolunteerResult
}

struct VolunteerResult: Decodable {
    let volunteers: [VolunteerItem]
}

struct VolunteerItem: Decodable {
    let id: Int
    let title: String
    let date: String
    let numberOfStaffs: Int
    let shelterName: String
    let region: String
}
