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

/// 네트워크 통신에는 성공했지만
/// 서버에서 업데이트를 실패했을 때 등의 경우가 errorCode에 담길 수 있기 때문에
/// Wrapper클래스를 만들어서 작성
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
