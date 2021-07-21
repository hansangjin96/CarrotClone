//
//  HomeReactor.swift
//  CarrotClone
//
//  Created by 한상진 on 2021/07/20.
//

import Foundation

import ReactorKit

final class HomeReactor: Reactor {
    
    // MARK: Events
    
    enum Action {
        case fetchCarrots
    }
    
    enum Mutation {
        case setCarrots(_ carrots: [Carrot])
    }
    
    struct State {
        var carrots: [Carrot] = []
    }
    
    // MARK: Property
    
    var initialState: State = .init()
    let errorResult: PublishSubject<Error> = .init()
    
    private let carrotService: CarrotServiceType
    
    // MARK: Init
    
    init(carrotService: CarrotServiceType) {
        self.carrotService = carrotService
    }
    
    deinit {
        print(type(of: self), #function)
    }
    
    // MARK: Mutation
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .fetchCarrots:
            return carrotService.fetchCarrot()
                .catch { [weak self] error in
                    guard let self = self else { return .empty() }
                    self.errorResult.onNext(error)
                    return .empty()
                }
                .map { Mutation.setCarrots($0) }
        }
    }
    
    // MARK: Reduce
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setCarrots(let carrots):
            newState.carrots = carrots
        }
        
        return newState
    }
    
    // MARK: Method    
}
