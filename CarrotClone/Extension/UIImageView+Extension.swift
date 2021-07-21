//
//  UIImageView+Extension.swift
//  CarrotClone
//
//  Created by 한상진 on 2021/07/21.
//

import UIKit

extension UIImageView {
    /// 사진을 메모리 캐시에 저장하기 위한 변수
    static let cache: NSCache<NSURL, UIImage> = .init().then {
        $0.countLimit = 100
    }
    
    /// Image를 다운로드 하기 위한 객체
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
