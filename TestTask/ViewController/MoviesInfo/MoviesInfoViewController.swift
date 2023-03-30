//
//  MoviesInfoViewController.swift
//  TestTask
//
//  Created by Yurii Honcharov on 28.03.2023.
//

import UIKit

protocol MoviesInfoViewControllerProtocol {
    func display(entity: MovieInfoApiEntity.MovieInfo)
    func reloadData()
}

class MoviesInfoViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var navigationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    // MARK: - Properties
    var presenter: MoviesInfoPresenterProtocol!
    var getId = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MoviesInfoPresenter(view: self)
        presenter.getData(id: getId)
        setupView()
    }
    
    func setupView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieIconTableViewCell.self)
        tableView.register(MovieDetailsTableViewCell.self)
        
        navigationLabel.text = L10n.movieToG()
        tableView.separatorStyle = .none
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension MoviesInfoViewController: MoviesInfoViewControllerProtocol {
    func display(entity: MovieInfoApiEntity.MovieInfo) {
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension MoviesInfoViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            // cell 1
            let cell = tableView.dequeue(MovieIconTableViewCell.self, indexPath)
            cell.display(entity: presenter.movieInfo)
            return cell
            // cell 2
        } else {
            let cell = tableView.dequeue(MovieDetailsTableViewCell.self, indexPath)
            cell.display(entity: presenter.movieInfo)
            return cell
        }
    }
    
}
