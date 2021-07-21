//
//  BaseVC.swift
//  CarrotClone
//
//  Created by 한상진 on 2021/07/20.
//

import UIKit

import Then
import RxSwift
import SnapKit

class BaseVC: UIViewController {
    
    final var disposeBag: DisposeBag = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupUI()
    }
    
    func setupUI() {
        // no-op
    }
}
