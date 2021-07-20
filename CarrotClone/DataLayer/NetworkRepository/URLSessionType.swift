//
//  URLSessionType.swift
//  CarrotClone
//
//  Created by 한상진 on 2021/07/20.
//

import Foundation

/// Test를 위해 추상화
protocol URLSessionType {
    func dataTask(
        with request: URLRequest, 
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
}

extension URLSession: URLSessionType {}
