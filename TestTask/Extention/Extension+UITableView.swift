//
//  Extension+UITableView.swift
//  Dogiz
//
//  Created by Sasha Voloshanov on 07.04.2021.
//

import UIKit

extension UITableView {
    func dequeue<T: UITableViewCell>(_ cell: T.Type, _ indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as! T
    }
    
    func register<T: UITableViewCell>(_ cell: T.Type) {
        self.register(UINib(nibName: T.identifier, bundle: nil), forCellReuseIdentifier: T.identifier)
    }
    
    func reloadTable(isAnimate: Bool) {
        if isAnimate {
            UIView.transition(with: self, duration: 0.25, options: .transitionCrossDissolve, animations: {
                self.reloadData()
            }, completion: nil)
        } else {
            self.reloadData()
        }
    }
}
