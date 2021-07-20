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
        case setCarrot(_ carrot: Carrot)
    }
    
    struct State {
        var carrot: Carrot?
    }
    
    // MARK: Property
    
    var initialState: State = .init()
    
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
                .map { Mutation.setCarrot($0) }
        }
    }
    
    // MARK: Reduce
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .setCarrot(let carrot):
            newState.carrot = carrot
        }
        
        return newState
    }
    
    // MARK: Method
}
