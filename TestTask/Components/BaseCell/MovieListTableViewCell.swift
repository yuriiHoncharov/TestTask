//
//  MovieListTableViewCell.swift
//  TestTask
//
//  Created by Yurii Honcharov on 24.03.2023.
//

import UIKit

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
}

extension MovieListTableViewCell: MovieListTableViewCellProtocol {
    func display(entity: MovieEntity) {
        moviesImage.setImage(from: entity.posterPath ?? "")
        self.nameLabel.text = entity.title
        self.infoLabel.text = entity.overview
        self.dateLabel.text = String("\(L10n.release) \(entity.releaseDate)")
    }
}
