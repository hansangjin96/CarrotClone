//
//  CarrotCloneTests.swift
//  CarrotCloneTests
//
//  Created by 한상진 on 2021/07/20.
//

import XCTest

import Quick
import Nimble
import RxBlocking

@testable import CarrotClone

/// expect에서 결과값을 비교하기 위해 추가
extension Carrot: Equatable {
    public static func == (lhs: Carrot, rhs: Carrot) -> Bool {
        return (lhs.ggeulol == rhs.ggeulol) && 
        (lhs.heartCount == rhs.heartCount) &&
        (lhs.imageURL == rhs.imageURL) &&
        (lhs.location == rhs.location) &&
        (lhs.price == rhs.price) &&
        (lhs.time == rhs.time) &&
        (lhs.title == rhs.title) 
    }
}

extension ResultBase: Equatable {
    public static func == (lhs: ResultBase<T>, rhs: ResultBase<T>) -> Bool {
        guard let leftCarrots = lhs.data as? [Carrot],
              let rightCarrots = rhs.data as? [Carrot]
        else {
            return false
        }
        return (lhs.errorCode == rhs.errorCode) && (lhs.isNextPage == rhs.isNextPage) && (leftCarrots == rightCarrots)
    }    
}

class NetworkRepositoryTest: QuickSpec {
    override func spec() {
        /// requestEndpoint 테스트
        // given
        describe("NetworkRepositoryType에서 requestEndpoint를 실행했을 때") {
            var sut: NetworkRepositoryType!
            var result: ResultBase<[Carrot]>!
            var expectedError: Error!
            
            // when
            context("정상적인 reponse가 오면") {
                beforeEach {
                    sut = NetworkRepository(with: MockURLSession())
                    result = try! sut.requestEndpoint(
                        with: .readCarrots,
                        for: ResultBase<[Carrot]>.self
                    ).toBlocking().first()
                }
                
                // then
                it("mock data와 같은 data를 받는다.") {
                    let expected = try! JSONDecoder().decode(
                        ResultBase<[Carrot]>.self,
                        from: MockURLSession.mockData
                    )
                    
                    expect(expected).to(equal(result))
                }
            }
            
            // when
            context("response의 status code가 잘못되었으면") {
                beforeEach {
                    sut = NetworkRepository(with: MockURLSession(isInvalidStatus: true))
                    do {
                        result = try sut.requestEndpoint(
                            with: .readCarrots,
                            for: ResultBase<[Carrot]>.self
                        ).toBlocking().first()
                    } catch {
                        expectedError = error
                    }
                }
                
                // then
                it("invalidStatus error가 나온다.") {
                    let expected = expectedError as! NetworkError
                    expect(expected).to(equal(NetworkError.invalidStatus))
                }
            }
            
            // when
            context("dataTask가 실패해 error가 나올 경우") {
                beforeEach {
                    sut = NetworkRepository(with: MockURLSession(dataTaskFail: true))
                    do {
                        result = try sut.requestEndpoint(
                            with: .readCarrots,
                            for: ResultBase<[Carrot]>.self
                        ).toBlocking().first()
                    } catch {
                        expectedError = error
                    }
                }
                
                // then
                it("dataTaskFail error가 나온다.") {
                    let expected = expectedError as! NetworkError
                    expect(expected).to(equal(NetworkError.dataTaskFail))
                }
            }
            
            // when
            context("data가 존재하지 않을 경우") {
                beforeEach {
                    sut = NetworkRepository(with: MockURLSession(noData: true))
                    do {
                        result = try sut.requestEndpoint(
                            with: .readCarrots,
                            for: ResultBase<[Carrot]>.self
                        ).toBlocking().first()
                    } catch {
                        expectedError = error
                    }
                }
                
                // then
                it("noData error가 나온다.") {
                    let expected = expectedError as! NetworkError
                    expect(expected).to(equal(NetworkError.noData))
                }
            }
        }
    }
}
