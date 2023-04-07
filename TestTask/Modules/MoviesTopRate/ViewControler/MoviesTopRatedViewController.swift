//
//  MoviesTopRatedViewController.swift
//  TestTask
//
//  Created by Yurii Honcharov on 04.04.2023.
//

import UIKit

protocol MoviesTopRatedViewControllerProtocol: AnyObject {
    func reloadData(with rows: [MovieEntity])
    func moveToMovieInfo(controller: UIViewController)
}

class MoviesTopRatedViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    // MARK: - Properties
    private var presenter: MoviesTopRatedPresenterProtocol!
    private var movies: [MovieEntity] = []
    private let dataSource = MovieTopRateDataSource()
    private let refreshControl = UIRefreshControl()
    
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
        refreshTable()
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
            self.presenter.moveToMovieInfo(indexPath)
        }
        dataSource.loadMoreItem = { self.presenter.getData() }
        loadModeData()
    }
    
    private func loadModeData() {
        dataSource.loadMoreItem = {
            self.presenter.getData()
        }
    }
    
    private func setupTableViewFooter() {
        // TODO: stop footer when load last item.
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

extension MoviesTopRatedViewController: MoviesTopRatedViewControllerProtocol {
    func reloadData(with rows: [MovieEntity]) {
        DispatchQueue.main.async {
            self.dataSource.updateData(rows: rows)
            self.movies = rows
            self.tableView.reloadTable(isAnimate: true)
        }
    }
    
    func moveToMovieInfo(controller: UIViewController) {
        navigationController?.pushViewController(controller, animated: true)
    }
}
