//
//  CarrotService.swift
//  CarrotClone
//
//  Created by 한상진 on 2021/07/20.
//

import Foundation

import RxSwift

protocol CarrotServiceType {
    func fetchCarrot() -> Observable<Carrot>
}

final class CarrotService: CarrotServiceType {
    func fetchCarrot() -> Observable<Carrot> {
        return .empty()
    }
}
