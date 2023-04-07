//
//  MovieIconTableViewCell.swift
//  TestTask
//
//  Created by Yurii Honcharov on 30.03.2023.
//

import UIKit

class MovieIconTableViewCell: UITableViewCell {
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var rateLabel: UILabel!
    @IBOutlet private weak var playImage: UIImageView!
    
    private var isShowVideo: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cleanDate()
        setupCell()
    }
    
    private func cleanDate() {
        posterImage.image = nil
        nameLabel.text = ""
        rateLabel.text = ""
        playImage.image = nil
    }
    
    private func setupCell() {
        // label
        self.nameLabel.font = UIFont(name: Constants.FontRaleway.bold, size: 16)
        self.rateLabel.font = UIFont(name: Constants.FontRaleway.semiBold, size: 12)
    }
    
    func display(entity: MovieInfoEntity) {
        playImage.isHidden = !entity.video
        isShowVideo = entity.video
        posterImage.setImage(from: entity.backdropPath)
        posterImage.addGradientLayerInBackground(frame: self.bounds, colors: [.clear, Colors.linearGradient.color])
        nameLabel.text = entity.title
        movieRateText(rate: String(format: "%.01f", entity.popularity))
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
