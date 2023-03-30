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
    
    func dequeueSupplementaryView<View: UICollectionReusableView>(at indexPath: IndexPath, ofKind kind: String, type: View.Type) -> View {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: View.identifier, for: indexPath) as! View
    }
    
    func registerSupplementaryView<View: UICollectionReusableView>(_ type: View.Type, ofKind kind: String) {
        let nib = UINib(nibName: View.identifier, bundle: Bundle(for: type))
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: View.identifier)
    }
    
    func dequeueHeader<T: UICollectionReusableView>(_ header: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: header.identifier, for: indexPath) as! T
    }
    
    func dequeueFooter<T: UICollectionReusableView>(_ header: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: header.identifier, for: indexPath) as! T
    }
    
    func registerHeader<T: UICollectionReusableView>(_ view: T.Type) {
        return self.register(UINib(nibName: view.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: view.identifier)
    }
    
    func registerFooter<T: UICollectionReusableView>(_ view: T.Type) {
        self.register(UINib(nibName: view.identifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: view.identifier)
    }
}

extension UICollectionViewCompositionalLayout {
    func registerSupplementaryView<View: UICollectionReusableView>(_ type: View.Type, ofKind kind: String) {
        let nib = UINib(nibName: View.identifier, bundle: Bundle(for: type))
        register(nib, forDecorationViewOfKind: View.identifier)
    }
}
