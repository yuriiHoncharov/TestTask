//
//  MovieListTableViewCell.swift
//  TestTask
//
//  Created by Yurii Honcharov on 24.03.2023.
//

import UIKit
import Kingfisher

protocol MovieListTableViewCellProtocol {
    func display(entity: MovieEntity)
}

class MovieListTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet private weak var view: UIView!
    @IBOutlet private weak var moviesImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    var buttonAction: (() -> Void)?
    let dateFormatter = DateFormatterUtility()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    private func setupCell() {
        view.layer.cornerRadius = 8
        self.nameLabel.font = UIFont(name: Constants.FontRaleway.bold, size: 14)
        self.infoLabel.font = UIFont(name: Constants.FontRaleway.regular, size: 12)
        self.dateLabel.font = UIFont(name: Constants.FontRaleway.semiBold, size: 12)
    }
    
    func displayForTop(entity: TopRateApiEntity.Item) {
        let correctDate = dateFormatter.refactoringDate(from: entity.releaseDate)
        moviesImage(string: entity.posterPath)
        self.nameLabel.text = entity.title
        self.infoLabel.text = entity.overview
        self.dateLabel.text = String("\(L10n.release()) \(correctDate)")
    }
    
    private func moviesImage(string: String) {
        let url = URL(string: Constants.imageUrl + ImageSize.original.rawValue + string)
        self.moviesImage.kf.setImage(with: url)
    }
}

extension MovieListTableViewCell: MovieListTableViewCellProtocol {
    func display(entity: MovieEntity) {
        let correctDate = dateFormatter.refactoringDate(from: entity.releaseDate)
        self.moviesImage(string: entity.posterPath ?? "")
        self.nameLabel.text = entity.title
        self.infoLabel.text = entity.overview
        self.dateLabel.text = String("\(L10n.release()) \(correctDate)")
    }
}