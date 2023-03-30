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
    
    func reloadDataWithAnimation(animation: CAMediaTimingFunctionName = .easeInEaseOut, duration: TimeInterval = 0.3, transition: CATransitionType = .push, transitionSubtype: CATransitionSubtype = .fromTop) {
        let transition = CATransition()
        transition.type = CATransitionType.push
        transition.timingFunction = CAMediaTimingFunction(name: animation)
        transition.fillMode = CAMediaTimingFillMode.forwards
        transition.duration = duration
        transition.subtype = CATransitionSubtype.fromRight
        self.layer.add(transition, forKey: "UITableViewReloadDataAnimationKey")
        self.reloadData()
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
    
    func scrollToBottom(isAnimated: Bool = true) {
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection: self.numberOfSections - 1) - 1,
                section: self.numberOfSections - 1)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .bottom, animated: isAnimated)
            }
        }
    }
    
    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
}
