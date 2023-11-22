//
//  MovieListTableViewController.swift
//  TestTask
//
//  Created by Yurii Honcharov on 24.03.2023.
//

import UIKit

protocol MovieListTableViewControllerProtocol: AnyObject {
    func reloadData(with rows: [MovieEntity])
    func moveToMovieInfo(id: Int)
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
        getData()
    }
    
    private func getData() {
        Task {
            await presenter.getData()
        }
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
        
        dataSource.loadMoreItem = { [weak self] in
            guard let self = self else { return }
            Task {
                await self.presenter.getData()
            }
        }
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
    
    func moveToMovieInfo(id: Int) {
        let vc = MoviesInfoViewController.fromStoryboard
        vc.setupPresenter(id: id)
        navigationController?.pushViewController(vc, animated: true)
    }
}
