//
//  MovieListTableViewController.swift
//  TestTask
//
//  Created by Yurii Honcharov on 24.03.2023.
//

import UIKit

protocol MovieListTableViewControllerProtocol: AnyObject {
    func reloadData()
}

class MovieListTableViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var navigationBarTitle: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    // MARK: - Properties
    var presenter: MovieListPresenterProtocol!
    var movies: [UpcomingApiEntity.Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MovieListPresenter(view: self)
        navigationBarTitle.text = L10n.movieToG()
        setupViews()
        presenter.getData()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: Colors.background.name)
        setupTable()
    }
    
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(MovieListTableViewCell.self)
        tableView.backgroundColor = UIColor(named: Colors.background.name)
    }
}

extension MovieListTableViewController: MovieListTableViewControllerProtocol {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadTable(isAnimate: true)
        }
    }
}

// MARK: - Table view data source
extension MovieListTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.movieUpcoming.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(MovieListTableViewCell.self, indexPath)
        print(presenter.movieUpcoming[indexPath.row].id)
        cell.display(entity: presenter.movieUpcoming[indexPath.row])
        cell.backgroundColor = UIColor(named: Colors.background.name)
        // cell.infoLabel.text = String(indexPath.row)
        if presenter.movieUpcoming.count - 1 == indexPath.row {
            presenter.getData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MoviesInfoViewController.fromStoryboard
        vc.getId = presenter.movieUpcoming[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
