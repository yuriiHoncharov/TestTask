//
//  Extension+UIImage.swift
//  TestTask
//
//  Created by Yurii Honcharov on 02.04.2023.
//

import UIKit

extension UIImageView {
    func load(string: String) {
        if let url = URL(string: Constants.imageUrl + string) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
