//
//  Cell+Extension.swift
//  CarrotClone
//
//  Created by 한상진 on 2021/07/22.
//

import UIKit

protocol ReusableIdentiable {
    static var reusableID: String { get }
}

extension ReusableIdentiable {
    static var reusableID: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableIdentiable { }
