//
//  CarrotService.swift
//  CarrotClone
//
//  Created by 한상진 on 2021/07/20.
//

import Foundation

import RxSwift

protocol CarrotServiceType {
    func fetchCarrot() -> Observable<[Carrot]>
}

final class CarrotService: CarrotServiceType {
    
    private let networkRepository: NetworkRepositoryType
    
    init(networkRepository: NetworkRepositoryType) {
        self.networkRepository = networkRepository
    }
    
    func fetchCarrot() -> Observable<[Carrot]> {
        return networkRepository.requestEndpoint(
            with: .readCarrots, 
            for: ResultBase<[Carrot]>.self
        )
        .asObservable()
        .flatMap { result -> Observable<[Carrot]> in
            if result.errorCode != ResultErrorCode.success.rawValue { return .error(NetworkError.invalidErrorCode) }
            return .just(result.data)
        }        
    }
}
