//
//  ViewController.swift
//  CarrotClone
//
//  Created by 한상진 on 2021/07/20.
//

import UIKit

import RxSwift
import RxCocoa
import ReactorKit

final class HomeVC: BaseVC {
    
    // MARK: UI Property
    
    private lazy var tableView: UITableView = .init().then {
        $0.register(HomeCell.self, forCellReuseIdentifier: HomeCell.reusableID)
        $0.rowHeight = 120
    }
    
    // MARK: Property
    
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
    
    // MARK: UI
    
    override func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
}

// MARK: Reactor

extension HomeVC: View {
    func bind(reactor: HomeReactor) {
        bindAction(reactor: reactor)
        bindState(reactor: reactor)
    }
    
    // MARK: Action
    
    private func bindAction(reactor: HomeReactor) {
        self.rx.sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .map { _ in Reactor.Action.fetchCarrots }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    // MARK: State
    
    private func bindState(reactor: HomeReactor) {
        reactor.state
            .compactMap(\.carrots)
            .observe(on: MainScheduler.instance)
            .bind(to: tableView.rx.items(
                cellIdentifier: HomeCell.reusableID, 
                cellType: HomeCell.self
            )) { index, element, cell in
                cell.bind(with: element)
            }
            .disposed(by: disposeBag)
        
        reactor.errorResult
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
                // TODO: ErrorHandling
                print($0)
            })
            .disposed(by: disposeBag)
    }
}
