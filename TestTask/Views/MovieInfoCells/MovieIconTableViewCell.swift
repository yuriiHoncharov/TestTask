//
//  MovieIconTableViewCell.swift
//  TestTask
//
//  Created by Yurii Honcharov on 30.03.2023.
//

import UIKit

class MovieIconTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func display(entity: MovieInfoApiEntity.MovieInfo) {
        posterImage.image = UIImage(named: entity.posterPath)
        nameLabel.text = entity.originalTitle
        movieRateText(rate: String(format: "%.01f", entity.voteAverage))
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