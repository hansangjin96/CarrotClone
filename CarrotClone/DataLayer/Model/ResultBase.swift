//
//  ResultBase.swift
//  CarrotClone
//
//  Created by 한상진 on 2021/07/20.
//

import Foundation

struct ResultBase<T: Codable>: Codable {
    let errorCode: Int
    let data: T
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case data
    }
}
