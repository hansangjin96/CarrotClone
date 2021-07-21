//
//  Tab.swift
//  CarrotClone
//
//  Created by 한상진 on 2021/07/21.
//

import UIKit

final class MainTabBarController: UITabBarController {
    enum Tab: CaseIterable {
        case home
        case life
        case nearBy
        case chatting
        case setting
        
        var tabBarItem: UITabBarItem {
            switch self {
            case .home: return .init(
                title: "홈",
                image: UIImage(systemName: "house"), 
                selectedImage: UIImage(systemName: "house.fill")
            )
            case .life: return .init(
                title: "동네생활", 
                image: UIImage(systemName: "doc"), 
                selectedImage: nil
            )    
            case .nearBy: return .init(
                title: "내 근처", 
                image: UIImage(systemName: "location"), 
                selectedImage: nil
            )    
            case .chatting: return .init(
                title: "채팅", 
                image: UIImage(systemName: "bubble.left.and.bubble.right"), 
                selectedImage: nil
            )    
            case .setting: return .init(
                title: "나의 당근",
                image: UIImage(systemName: "person"), 
                selectedImage: nil
            )    
            }
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let tabs: [UIViewController] = Tab.allCases.map { tab in 
            switch tab {
            case .home:
                let urlSession: URLSessionType = MockURLSession()
                let networkRepository: NetworkRepositoryType = NetworkRepository(with: urlSession)
                let service: CarrotServiceType = CarrotService(networkRepository: networkRepository)
                let reactor: HomeReactor = .init(carrotService: service)
                let vc: HomeVC = .init(with: reactor)
                let navi: UINavigationController = .init(rootViewController: vc)
                navi.tabBarItem = tab.tabBarItem
                return navi
            case .life: 
                let vc: BaseVC = .init()
                let navi: UINavigationController = .init(rootViewController: vc)
                navi.tabBarItem = tab.tabBarItem
                return navi
            case .nearBy: 
                let vc: BaseVC = .init()
                let navi: UINavigationController = .init(rootViewController: vc)
                navi.tabBarItem = tab.tabBarItem
                return navi
            case .chatting: 
                let vc: BaseVC = .init()
                let navi: UINavigationController = .init(rootViewController: vc)
                navi.tabBarItem = tab.tabBarItem
                return navi
            case .setting: 
                let vc: BaseVC = .init()
                let navi: UINavigationController = .init(rootViewController: vc)
                navi.tabBarItem = tab.tabBarItem
                return navi
            } 
        }
        
        self.setViewControllers(tabs, animated: false)
    }
}
