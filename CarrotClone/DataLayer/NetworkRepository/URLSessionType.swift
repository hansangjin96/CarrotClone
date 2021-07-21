//
//  URLSessionType.swift
//  CarrotClone
//
//  Created by 한상진 on 2021/07/20.
//

import Foundation

/// Test를 위한 추상화 protocol
protocol URLSessionType {
    func dataTask(
        with request: URLRequest, 
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
    
    func dataTask(
        with url: URL, 
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
}

extension URLSession: URLSessionType {}

final class MockURLSessionDataTask: URLSessionDataTask {
    override init() { }
    
    var resumeDidCall: () -> Void = { }
    
    override func resume() {
        resumeDidCall()
    }
    
    override func cancel() {
        print(type(of: self), #function)
    }
}

/// 실제 API가 없어서 Test를 위한 객체와 가짜 API를 받는 객체를 여기서 생성
final class MockURLSession: URLSessionType {
    private let isInvalidStatus: Bool
    private let dataTaskFail: Bool
    private let noData: Bool
    
    init(
        isInvalidStatus: Bool = false,
        dataTaskFail: Bool = false,
        noData: Bool = false
    ) {
        self.isInvalidStatus = isInvalidStatus
        self.dataTaskFail = dataTaskFail
        self.noData = noData
    }
    
    func dataTask(
        with request: URLRequest, 
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        let dataTask = MockURLSessionDataTask()
        let response = HTTPURLResponse(
            url: URL(string: "http://carrot.mock.com")!,
            statusCode: 200,
            httpVersion: "2",
            headerFields: [HTTPHeaderFields.contentType: HTTPHeaderFields.json]
        )
        
        let failResponse = HTTPURLResponse(
            url: URL(string: "http://carrot.mock.com")!,
            statusCode: 404,
            httpVersion: "2",
            headerFields: [HTTPHeaderFields.contentType: HTTPHeaderFields.json]
        ) 
        
        if self.isInvalidStatus {
            completionHandler(MockURLSession.mockData, failResponse, nil) 
        } else if self.noData {
            completionHandler(nil, response, nil)
        } else if self.dataTaskFail {
            completionHandler(
                MockURLSession.mockData, 
                response, 
                NSError(
                    domain: "mockError", 
                    code: -100, 
                    userInfo: nil
                )
            )
        } else {
            completionHandler(MockURLSession.mockData, response, nil)
        }
        
        return dataTask
    }
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let dataTask = MockURLSessionDataTask()
        return dataTask
    }
    
    /// TableView에 fake data를 뿌려주기 위해 만든 data
    static var mockData: Data {
        return Data(
        """
        {
          "error_code": 0,
          "is_next_page": true,
          "data": [
            {
              "image_url": "https://newsimg.hankookilbo.com/cms/articlerelease/2019/04/29/201904291390027161_3.jpg",
              "title": "마놀로블라닉 샌들",
              "location": "송파구 문정동",
              "time": "10초 전",
              "ggeulol": true,
              "price": 180000,
              "heart_count": 0
            },
            {
              "image_url": "http://www.palnews.co.kr/news/photo/201801/92969_25283_5321.jpg",
              "title": "여아 원피스",
              "location": "송파구 오금동",
              "time": "20초 전",
              "ggeulol": false,
              "price": 48000,
              "heart_count": 3
            },
            {
              "image_url": "http://image.dongascience.com/Photo/2019/12/43a8a87814b98b5346192ec9855f5883.jpg",
              "title": "Time 원피스",
              "location": "송파구 오금동",
              "time": "35초 전",
              "ggeulol": true,
              "price": 20000,
              "heart_count": 7
            },
            {
              "image_url": "http://image.dongascience.com/Photo/2015/10/14454922182366.jpg",
              "title": "Time 원피스",
              "location": "송파구 오금동",
              "time": "35초 전",
              "ggeulol": true,
              "price": 20000,
              "heart_count": 7
            },
            {
              "image_url": "https://thumb.mt.co.kr/06/2021/03/2021030917585165860_2.jpg/dims/optimize/",
              "title": "Time 원피스",
              "location": "송파구 오금동",
              "time": "35초 전",
              "ggeulol": true,
              "price": 20000,
              "heart_count": 7
            },
            {
              "image_url": "https://cdn.edujin.co.kr/news/photo/202105/35768_68227_247.jpg",
              "title": "Time 원피스",
              "location": "송파구 오금동",
              "time": "35초 전",
              "ggeulol": true,
              "price": 20000,
              "heart_count": 7
            },
            {
              "image_url": "https://images.mypetlife.co.kr/content/uploads/2019/09/09152948/cat-baby-4208578_1920.jpg",
              "title": "Time 원피스",
              "location": "송파구 오금동",
              "time": "35초 전",
              "ggeulol": true,
              "price": 20000,
              "heart_count": 7
            }
          ]
        }
        """.utf8
        )
    }
}
