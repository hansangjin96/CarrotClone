//
//  HomeCell.swift
//  CarrotClone
//
//  Created by 한상진 on 2021/07/21.
//

import UIKit

// MARK: Protocol

protocol ReusableIdentiable {
    static var reusableID: String { get }
}

extension ReusableIdentiable {
    static var reusableID: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableIdentiable { }

// MARK: HomeCell

final class HomeCell: UITableViewCell {
    
    // MARK: UI Property
    
    private let productImage: UIImageView = .init().then {
        $0.contentMode = .scaleAspectFit
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
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI
    
    private func setupUI() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(productImage)
        productImage.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview().inset(20)
            $0.width.equalTo(productImage.snp.height).multipliedBy(1)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(productImage.snp.right).offset(10)
            $0.top.equalTo(productImage.snp.top)
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
        // TODO: ImageHandling
        do {
            let imageData = try Data(contentsOf: carrot.imageURL)
            DispatchQueue.main.async {
                self.productImage.image = UIImage(data: imageData)
            }
            
        } catch {
            print(error)
        }
        titleLabel.text = carrot.title
        locationLabel.text = carrot.location
        timeLabel.text = "* \(carrot.time)"
        priceLabel.text = "\(carrot.price)원"
    }
}
