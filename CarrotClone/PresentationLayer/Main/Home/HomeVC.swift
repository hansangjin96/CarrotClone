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
    
    private let activityIndicator: UIActivityIndicatorView = .init(style: .medium).then {
        $0.color = .systemBlue
    }
    
    private let addCarrotButton: UIButton = .init().then {
        $0.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        $0.tintColor = .orange
        $0.contentMode = .scaleAspectFill
        $0.contentHorizontalAlignment = .fill
        $0.contentVerticalAlignment = .fill
    }
    
    private let alarmButtonItem: UIBarButtonItem = .init(customView: UIButton().then {
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.frame = .init(x: 0, y: 0, width: 30, height: 30)
    })
    
    private let categoryButtonItem: UIBarButtonItem = .init(customView: UIButton().then {
        $0.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        $0.frame = .init(x: 0, y: 0, width: 30, height: 30)
    })
    
    private let searchButtonItem: UIBarButtonItem = .init(customView: UIButton().then {
        $0.setImage(UIImage(systemName: "bell"), for: .normal)
        $0.frame = .init(x: 0, y: 0, width: 30, height: 30)
    })
    
    private let locationButtonItem: UIBarButtonItem = .init(
        title: "문정동", 
        style: .plain,
        target: nil,
        action: nil
    )
        
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
        setupNavigation()
        setupViews()
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.rightBarButtonItems = [searchButtonItem, categoryButtonItem, alarmButtonItem]
        navigationItem.leftBarButtonItem = locationButtonItem
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.size.equalTo(50)
            $0.center.equalToSuperview()
        }
        
        view.addSubview(addCarrotButton)
        addCarrotButton.snp.makeConstraints {
            $0.bottom.right.equalTo(view.safeAreaLayoutGuide).inset(15)
            $0.size.equalTo(50)
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
            .do(onNext: { [weak self] _ in 
                self?.activityIndicator.startAnimating()
            })
            .map { _ in Reactor.Action.fetchCarrots }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    // MARK: State
    
    private func bindState(reactor: HomeReactor) {
        reactor.state
            .compactMap(\.carrots)
            .observe(on: MainScheduler.instance)
            .do(onNext: { [weak self] _ in 
                self?.activityIndicator.stopAnimating()
            })
            .bind(to: tableView.rx.items(
                cellIdentifier: HomeCell.reusableID, 
                cellType: HomeCell.self
            )) { index, element, cell in
                cell.bind(with: element)
            }
            .disposed(by: disposeBag)
        
        reactor.errorResult
            .observe(on: MainScheduler.instance)
            .do(onNext: { [weak self] _ in 
                self?.activityIndicator.stopAnimating()
            })
            .subscribe(onNext: { [weak self] error in
                let alertController = UIAlertController(
                    title: "Some Error Occurred",
                    message: error.localizedDescription,
                    preferredStyle: .alert
                )
                let okAction: UIAlertAction = .init(title: "confirm", style: .cancel)
                alertController.addAction(okAction)
                
                self?.present(alertController, animated: true)
            })
            .disposed(by: disposeBag)
    }
}
