//
//  MovieListTableViewController.swift
//  TestTask
//
//  Created by Yurii Honcharov on 24.03.2023.
//

import UIKit

protocol MovieListTableViewControllerProtocol: AnyObject, UIViewController {
    func reloadData(with rows: [MovieEntity])
}

class MovieListTableViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    // MARK: - Properties
    private var presenter: MovieListPresenterProtocol!
    private let dataSource = MovieListDataSource()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MovieListPresenter(view: self)
        setupViews()
        presenter.getData()
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor(named: Colors.background.name)
        setupTable()
        refreshTable()
        setupDataSource()
    }
    
    private func setupTable() {
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        tableView.separatorStyle = .none
        tableView.register(MovieListTableViewCell.self)
        tableView.backgroundColor = UIColor(named: Colors.background.name)
        
        setupTableViewFooter()
    }
    
    private func setupDataSource() {
        self.dataSource.didSelectRowAt = { [weak self] indexPath in
            guard let self else { return }
            self.presenter.moveToMovieInfo(indexPath)
        }
        dataSource.loadMoreItem = { self.presenter.getData() }
    }
    
    private func setupTableViewFooter() {
        let footer: LoadingFooterView = .fromNib()
        footer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        tableView.tableFooterView = footer
    }
    
    private func refreshTable() {
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        presenter.reloadData()
        refreshControl.endRefreshing()
    }
}

extension MovieListTableViewController: MovieListTableViewControllerProtocol {
    func reloadData(with rows: [MovieEntity]) {
        DispatchQueue.main.async {
            self.dataSource.updateData(rows: rows)
            self.tableView.reloadTable(isAnimate: true)
        }
    }
}
