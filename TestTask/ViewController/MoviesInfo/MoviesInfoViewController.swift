//
//  MoviesInfoViewController.swift
//  TestTask
//
//  Created by Yurii Honcharov on 28.03.2023.
//

import UIKit

protocol MoviesInfoViewControllerProtocol {
    func display(entity: MovieInfoApiEntity.MovieInfo)
}

class MoviesInfoViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var navigationLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieRateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    @IBOutlet weak var movieReleaseLabel: UILabel!
    // MARK: - Properties
    var presenter: MoviesInfoPresenterProtocol!
    var getId = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MoviesInfoPresenter(view: self)
        navigationLabel.text = L10n.movieToG()
        descriptionLabel.text = L10n.description()
        movieImage.cornerRadius = 8
        presenter.getData(id: getId)
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
        movieRateLabel.attributedText = myString
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MoviesInfoViewController: MoviesInfoViewControllerProtocol {
    func display(entity: MovieInfoApiEntity.MovieInfo) {
        movieImage.image = UIImage(named: entity.posterPath)
        movieNameLabel.text = entity.originalTitle
        movieDescriptionLabel.text = entity.overview
        movieReleaseLabel.text = entity.releaseDate
        movieRateText(rate: String(format: "%.01f", entity.voteAverage))
    }
}
