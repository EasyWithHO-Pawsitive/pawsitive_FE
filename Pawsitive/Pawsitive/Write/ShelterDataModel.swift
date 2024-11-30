//
//  ShelterDataModel.swift
//  Pawsitive
//
//  Created by 성호은 on 11/30/24.
//

import Foundation

struct ShelterResponse: Decodable {
    let isSuccess: Bool
    let message: String
    let result: ShelterResult
}

struct ShelterResult: Decodable {
    let shelterInfos: [Shelter]
}

struct Shelter: Decodable {
    let id: Int
    let name: String
}
