//
//  NetworkRepository.swift
//  CarrotClone
//
//  Created by 한상진 on 2021/07/20.
//

import Foundation

import RxSwift

protocol NetworkRepositoryType {
    func requestEndpoint<T: Decodable>(with endpoint: Endpoint, for type: T.Type) -> Single<T>
}

final class NetworkRepository: NetworkRepositoryType {
    
    private let session: URLSessionType
    
    init(with session: URLSessionType) {
        self.session = session
    }
    
    func requestEndpoint<T: Decodable>(
        with endpoint: Endpoint,
        for type: T.Type
    ) -> Single<T> {
        return Single<T>.create { [weak self] single in
            guard let self = self else { 
                return Disposables.create { single(.failure(NetworkError.noSelf)) } 
            }
            
            guard let request = try? endpoint.asURLRequest() else {
                return Disposables.create { single(.failure(NetworkError.urlToUrlRequest)) }
            }
            
            let task = self.session.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    single(.failure(NetworkError.dataTask))
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    single(.failure(NetworkError.responseCasting))
                    return
                }
                
                let correctStatusCodeRange: Range<Int> = 200..<300
                guard correctStatusCodeRange ~= response.statusCode else {
                    single(.failure(NetworkError.invalidStatus))
                    return
                }
                
                guard let data = data else {
                    single(.failure(NetworkError.noData))
                    return
                }
                
                guard let result = try? JSONDecoder().decode(T.self, from: data) else {
                    single(.failure(NetworkError.unableToDecode))
                    return
                }
                
                single(.success(result))
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
