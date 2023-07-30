//
//  UITableViewCell+Extension.swift
//  MusicApp
//
//  Created by Enes İşler on 4.07.2023.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
