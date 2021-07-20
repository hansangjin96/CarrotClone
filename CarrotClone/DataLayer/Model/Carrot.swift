//
//  Model.swift
//  CarrotClone
//
//  Created by 한상진 on 2021/07/20.
//

import Foundation

struct Carrot: Decodable {
    let imageURL: URL
    let title: String
    let location: String
    let time: String
    let ggeulol: Bool
    let price: Int
    let heartCount: Int
    
    enum CodingKeys: String, CodingKey {
        case imageURL = "image_url"
        case title
        case location
        case time
        case ggeulol
        case price
        case heartCount = "heart_count"
    }
}
