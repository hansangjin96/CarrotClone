//
//  ViewController.swift
//  CarrotClone
//
//  Created by 한상진 on 2021/07/20.
//

import UIKit

import ReactorKit

final class HomeVC: BaseVC {
    
    // MARK: Init
    
    init(with reactor: HomeReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print(type(of: self), #function)
    }
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
}

// MARK: Reactor

extension HomeVC: View {
    func bind(reactor: HomeReactor) {
        
    }
    
    // MARK: Action
    
    private func bindAction(reactor: HomeReactor) {
        
    }
    
    // MARK: State
    
    private func bindState(reactor: HomeReactor) {
        
    }
} 
