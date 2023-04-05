//
//  MoviesTopRatedViewController.swift
//  TestTask
//
//  Created by Yurii Honcharov on 04.04.2023.
//

import UIKit

protocol MoviesTopRatedViewControllerProtocol: AnyObject {
    func reloadData(with rows: [MovieEntity])
}

class MoviesTopRatedViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    // MARK: - Properties
    private var presenter: MoviesTopRatedPresenterProtocol!
    private var movies: [MovieEntity] = []
    private let dataSource = MovieTopRateDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MoviesTopRatedPresenter(view: self)
        setupView()
        presenter.getData()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: Colors.background.name)
        setupTable()
        setupDataSource()
        loadModeData()
    }
    
    private func setupTable() {
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        tableView.backgroundColor = UIColor(named: Colors.background.name)
        tableView.separatorStyle = .none
        tableView.register(MovieListTableViewCell.self)
        
        setupTableViewFooter()
    }
    
    private func setupDataSource() {
        self.dataSource.didSelectRowAt = { [weak self] indexPath in
            guard let self else { return }
            let vc = MoviesInfoViewController.fromStoryboard
            vc.getId = self.movies[indexPath.row].id
            print(self.movies[indexPath.row].id)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func loadModeData() {
        dataSource.loadMoreItem = {
            self.presenter.getData()
        }
    }
    
    private func setupTableViewFooter() {
        let footer: LoadingFooterView = .fromNib()
        footer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        tableView.tableFooterView = footer
    }
}

extension MoviesTopRatedViewController: MoviesTopRatedViewControllerProtocol {
    func reloadData(with rows: [MovieEntity]) {
        DispatchQueue.main.async {
            self.dataSource.updateData(rows: rows)
            self.movies.append(contentsOf: rows)
            self.tableView.reloadTable(isAnimate: true)
        }
    }
}
