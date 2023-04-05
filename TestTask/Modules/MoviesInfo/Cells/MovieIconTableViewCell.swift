//
//  MovieIconTableViewCell.swift
//  TestTask
//
//  Created by Yurii Honcharov on 30.03.2023.
//

import UIKit
import Kingfisher

class MovieIconTableViewCell: UITableViewCell {
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var rateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    private func setupCell() {
        self.nameLabel.font = UIFont(name: Constants.FontRaleway.bold, size: 16)
        self.rateLabel.font = UIFont(name: Constants.FontRaleway.semiBold, size: 12)
    }
    
    func display(entity: MovieInfoApiEntity.MovieInfo) {
        moviesImage(string: entity.backdropPath)
        nameLabel.text = entity.originalTitle
        movieRateText(rate: String(format: "%.01f", entity.voteAverage))
    }
    
    private func moviesImage(string: String) {
        let url = URL(string: Constants.imageUrl + ImageSize.original.rawValue + string)
        self.posterImage.kf.setImage(with: url)
    }
    
    private func movieRateText(rate: String) {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: Images.star.name)
        attachment.bounds = CGRect(x: 0, y: -4, width: 16, height: 16)
        let attachmentStr = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: "")
        let myString1 = NSMutableAttributedString(string: " \(rate) ")
        myString.append(myString1)
        myString.append(attachmentStr)
        rateLabel.attributedText = myString
    }
}
