//
//  HomeCell.swift
//  CarrotClone
//
//  Created by 한상진 on 2021/07/21.
//

import UIKit

final class HomeCell: UITableViewCell {
    
    // MARK: UI Property
    
    private let productImage: UIImageView = .init().then {
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .systemGray6
    }
    
    private let titleLabel: UILabel = .init().then {
        $0.font = .systemFont(ofSize: 12)
    }
    
    private let locationLabel: UILabel = . init().then { 
        $0.font = .systemFont(ofSize: 8)
    }
    
    private let timeLabel: UILabel = . init().then { 
        $0.font = .systemFont(ofSize: 8)
    }
    
    private let priceLabel: UILabel = . init().then { 
        $0.font = .systemFont(ofSize: 13, weight: .bold)
    }
    
    private let activityIndicator: UIActivityIndicatorView = .init(style: .medium).then { 
        $0.color = .systemBlue
    }
    
    // MARK: Property
    
    private var imageDownloadTask: URLSessionDataTask?
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // 재사용될 때 자신이 가지고 있는 이미지 다운로드 task 캔슬처리
        imageDownloadTask?.cancel()
        
        productImage.image = .none
        titleLabel.text = .none
        timeLabel.text = .none
        locationLabel.text = .none
        priceLabel.text = .none
        activityIndicator.stopAnimating()
    }
    
    // MARK: UI
    
    private func setupUI() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(productImage)
        productImage.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview().inset(20)
            $0.width.equalTo(productImage.snp.height).multipliedBy(1)
        }
        
        productImage.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalToSuperview().dividedBy(5)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(productImage.snp.right).offset(10)
            $0.top.equalTo(productImage.snp.top).offset(10)
        }
        
        contentView.addSubview(locationLabel)
        locationLabel.snp.makeConstraints {
            $0.left.equalTo(titleLabel.snp.left)
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
        }
        
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(locationLabel)
            $0.left.equalTo(locationLabel.snp.right).offset(5)
        }
        
        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(10)
            $0.left.equalTo(locationLabel.snp.left)
        }
    }
    
    // MARK: Bind
    
    func bind(with carrot: Carrot) {
        activityIndicator.startAnimating()
        imageDownloadTask = productImage.setImage(with: carrot.imageURL) {
            self.activityIndicator.stopAnimating()
        }
        
        titleLabel.text = carrot.title
        locationLabel.text = carrot.location
        timeLabel.text = "* \(carrot.time)"
        priceLabel.text = "\(carrot.price)원"
    }
}
