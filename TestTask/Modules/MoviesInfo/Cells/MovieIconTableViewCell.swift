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
        resetContent()
        setupCell()
    }
    
    private func resetContent() {
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
        rateLabel.text = String(format: "%.01f", entity.popularity)
    }
}
