//
//  ImageService.swift
//  CarrotClone
//
//  Created by 한상진 on 2021/07/21.
//

import UIKit

protocol ImageServiceType {
    func downloadImage(
        with url: URL, 
        completion: @escaping (Result<UIImage, Error>) -> Void
    ) -> URLSessionDataTask
}

enum ImageDownloadError: Error {
    case networkError
    case responseError
    case dataError
}

final class ImageService: ImageServiceType {
    private let session: URLSessionType
    
    init(with session: URLSessionType = URLSession(configuration: .default)) {
        self.session = session
    }
    
    func downloadImage(
        with url: URL,
        completion: @escaping (Result<UIImage, Error>) -> Void
    ) -> URLSessionDataTask {
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(ImageDownloadError.networkError))
                return 
            }
            
            guard let response = response as? HTTPURLResponse,
                  200..<300 ~= response.statusCode 
            else {
                completion(.failure(ImageDownloadError.responseError))
                return
            }
            
            guard let data = data, 
                  let image = UIImage(data: data) 
            else {
                completion(.failure(ImageDownloadError.dataError))
                return
            }
            
            completion(.success(image))
        }
        
        task.resume()
        
        return task
    }
}
