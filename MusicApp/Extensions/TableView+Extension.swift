//
//  TableView+Extension.swift
//  MusicApp
//
//  Created by Enes İşler on 4.07.2023.
//

import Foundation
import UIKit

extension UITableView {
    func register(cellType: UITableViewCell.Type) {
        register(cellType.nib, forCellReuseIdentifier: cellType.identifier)
    }
    
    func dequeCell<T: UITableViewCell>(cellType: T.Type, indexPath: IndexPath)-> T {
        guard let cell = dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as? T else {
            fatalError("Error!")
        }
        
        return cell
    }
}
