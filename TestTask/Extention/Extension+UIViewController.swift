//
//  Extension+UIViewController.swift
//  Dogiz
//
//  Created by Sasha Voloshanov on 02.04.2021.
//

import UIKit

extension UIViewController {
    static var fromStoryboard: Self {
        let selfName = NSStringFromClass(self).components(separatedBy: ".").last!
        let storyboard = UIStoryboard(name: selfName, bundle: nil)
        let customViewController = storyboard.instantiateViewController(withIdentifier: selfName) as! Self
        
        return customViewController
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
