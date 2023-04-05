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
    
    let dateUtility: DateFormatterUtility = DateFormatterUtility()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    private func setupCell() {
        descriptionLabel.text = L10n.description()
        descriptionLabel.font = UIFont(name: Constants.FontRaleway.semiBold, size: 16)
        movieDescriptionLabel.font = UIFont(name: Constants.FontRaleway.regular, size: 14)
        releaseLabel.font = UIFont(name: Constants.FontRaleway.semiBold, size: 14)
    }
    
    func display(entity: MovieInfoApiEntity.MovieInfo) {
        let correctDate = dateUtility.refactoringDate(from: entity.releaseDate)
        movieDescriptionLabel.text = entity.overview
        releaseLabel.text = correctDate
    }
}
