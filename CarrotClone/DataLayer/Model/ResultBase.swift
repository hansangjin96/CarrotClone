//
//  ResultBase.swift
//  CarrotClone
//
//  Created by 한상진 on 2021/07/20.
//

import Foundation

enum ResultErrorCode: Int, Error {
    case success = 0
    case updateFail = -100
    case databaseFail = -200
}

struct ResultBase<T: Decodable>: Decodable {
    let errorCode: Int
    let isNextPage: Bool?
    let data: T
    
    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case isNextPage = "is_next_page"
        case data
    }
}
