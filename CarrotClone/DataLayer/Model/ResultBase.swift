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
    
    var mockData: Data {
        return Data(
        """
        {
            error_code: -100,
            data: {
                [
                    {
                        imageURL: "http://carrot.image.mock.jpg"
                        title: "마놀로블라닉 샌들"
                        location: "송파구 문정동"
                        time: "10초 전"
                        ggeulol: true
                        price: 180000
                        heartCount: 0
                    },
                    {
                        imageURL: "http://carrot.image.mock.jpg2"
                        title: "여아 원피스"
                        location: "송파구 오금동"
                        time: "20초 전"
                        ggeulol: false
                        price: 48000
                        heartCount: 3
                    },
                    {
                        imageURL: "http://carrot.image.mock.jpg3"
                        title: "Time 원피스"
                        location: "송파구 오금동"
                        time: "35초 전"
                        ggeulol: true
                        price: 20000
                        heartCount: 7
                    }
                ]
            }
        }
        """.utf8
        )
    }
}
