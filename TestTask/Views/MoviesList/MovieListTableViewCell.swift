//
//  MovieListTableViewCell.swift
//  TestTask
//
//  Created by Yurii Honcharov on 24.03.2023.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var moviesImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var buttonAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.layer.cornerRadius = 10
    }
    
    func display(entity: UpcomingApiEntity.Item) {
        self.moviesImage.image = UIImage(named: entity.posterPath ?? "")
        self.nameLabel.text = entity.title
        self.infoLabel.text = entity.overview
        self.dateLabel.text = String("\(L10n.release()) \(entity.releaseDate)")
    }
}
