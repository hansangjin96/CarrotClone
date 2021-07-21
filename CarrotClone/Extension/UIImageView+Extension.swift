//
//  UIImageView+Extension.swift
//  CarrotClone
//
//  Created by 한상진 on 2021/07/21.
//

import UIKit

extension UIImageView {
    static let cache: NSCache<NSURL, UIImage> = .init().then {
        $0.countLimit = 100
    }
    
    private var imageService: ImageServiceType {
        return ImageService()
    }
    
    func setImage(with url: URL, completion: (() -> Void)?) -> URLSessionDataTask? {
        /// 캐시에 image가 이미 있으면 리턴
        if let image = UIImageView.cache.object(forKey: url as NSURL) {
            self.image = image
            completion?()
            return nil
        }
        
        /// 이미지 다운로드
        return imageService.downloadImage(with: url) { result in
            switch result {
            case .success(let image):
                UIImageView.cache.setObject(image, forKey: url as NSURL)
                DispatchQueue.main.async {
                    self.image = image
                    completion?()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.image = .none // error image
                    print(error)
                    completion?()
                }
            }
        }
    }
}
