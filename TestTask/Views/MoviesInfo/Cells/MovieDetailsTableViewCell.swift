//
//  MovieDetailsTableViewCell.swift
//  TestTask
//
//  Created by Yurii Honcharov on 30.03.2023.
//

import UIKit

class MovieDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var movieDescriptionLabel: UILabel!
    @IBOutlet private weak var releaseLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        descriptionLabel.text = L10n.description()
    }
    
    func display(entity: MovieInfoApiEntity.MovieInfo) {
        movieDescriptionLabel.text = entity.overview
        releaseLabel.text = entity.releaseDate
    }
    
}
