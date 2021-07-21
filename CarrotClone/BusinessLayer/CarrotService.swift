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

/// 앱의 business logic을 담당
/// 각각의 network call에 대해 다른 에러 핸들링을 하거나
/// 네트워크에서 받은 raw한 enitity를 viewModel에서 사용할 실제 model로 변환
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
        .flatMapLatest { result -> Observable<[Carrot]> in
            if result.errorCode != ResultErrorCode.success.rawValue { 
                return .error(NetworkError.invalidErrorCode)
            }
            return .just(result.data)
        }
    }
}
