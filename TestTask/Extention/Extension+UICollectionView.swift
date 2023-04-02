//
//  Extension+UICollectionView.swift
//  Dogiz
//
//  Created by Sasha Voloshanov on 05.04.2021.
//

import UIKit

extension UICollectionView {
    func dequeue<T: UICollectionViewCell>(_ cell: T.Type, _ indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withReuseIdentifier: cell.identifier, for: indexPath) as! T
    }
    
    func register<T: UICollectionViewCell>(_ cell: T.Type) {
        self.register(UINib(nibName: cell.identifier, bundle: nil), forCellWithReuseIdentifier: cell.identifier)
    }
}
