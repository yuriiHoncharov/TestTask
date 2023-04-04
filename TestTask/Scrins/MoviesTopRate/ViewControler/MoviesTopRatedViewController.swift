//
//  MoviesTopRatedViewController.swift
//  TestTask
//
//  Created by Yurii Honcharov on 04.04.2023.
//

import UIKit

protocol MoviesTopRatedViewControllerProtocol: AnyObject {
    func reloadData()
}

class MoviesTopRatedViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    // MARK: - Properties
    var presenter: MoviesTopRatedPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MoviesTopRatedPresenter(view: self)
        setupView()
        presenter.getData()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: Colors.background.name)
        setupTable()
    }
    
    private func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor(named: Colors.background.name)
        tableView.separatorStyle = .none
        tableView.register(MovieListTableViewCell.self)
    }
}

extension MoviesTopRatedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.movieTopRate.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(MovieListTableViewCell.self, indexPath)
        cell.displayForTop(entity: presenter.movieTopRate[indexPath.row])
        
        cell.backgroundColor = UIColor(named: Colors.background.name)
        if presenter.movieTopRate.count - 1 == indexPath.row {
            presenter.getData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MoviesInfoViewController.fromStoryboard
        vc.getId = presenter.movieTopRate[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let isNeedLoadingHandler = presenter.isLoadMoreItem
        let loadingHandlerView: LoadingFooterView = .fromNib()
        let view = UIView()
        view.backgroundColor = UIColor(named: Colors.baseOrange.name)
        
        return isNeedLoadingHandler ? loadingHandlerView : view
    }
}

extension MoviesTopRatedViewController: MoviesTopRatedViewControllerProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadTable(isAnimate: true)
        }
    }
}
