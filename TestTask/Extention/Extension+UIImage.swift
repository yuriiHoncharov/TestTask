//
//   Extension+UIImage.swift
//  TestTask
//
//  Created by Yurii Honcharov on 07.04.2023.
//

import Foundation
import Kingfisher

protocol ImageLoadable {}
extension UIImageView: ImageLoadable {}

extension ImageLoadable where Self: UIImageView {
    func setImage(from string: String) {
        let url = URL(string: Constants.imageUrl + ImageSize.original.rawValue + string)
        self.kf.setImage(with: url)
    }
}
