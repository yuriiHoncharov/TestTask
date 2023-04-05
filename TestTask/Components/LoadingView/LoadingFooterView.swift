//
//  LoadingFooterView.swift
//  TestTask
//
//  Created by Yurii Honcharov on 04.04.2023.
//

import UIKit

class LoadingFooterView: UIView {
    @IBOutlet weak var loadIndicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        loadIndicatorView.startAnimating()
        
        self.loadIndicatorView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
    }
    
    class func fromNib() -> LoadingFooterView {
        return UINib(nibName: String(describing: self), bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! LoadingFooterView
    }
    
    func setIndicatorViewColor(_ color: UIColor) {
        loadIndicatorView.color = color
    }
}
