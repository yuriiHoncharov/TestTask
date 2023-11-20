//
//  MoviesInfoViewController.swift
//  TestTask
//
//  Created by Yurii Honcharov on 28.03.2023.
//

import UIKit

protocol MoviesInfoViewControllerProtocol: AnyObject {
    func display(entity: MovieInfoEntity)
    func reloadData()
    func setupPresenter(id: Int)
}

class MoviesInfoViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    // MARK: - Properties
    var presenter: MoviesInfoPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getData()
    }

    private func getData() {
        Task {
            await presenter.getData()
        }
    }

    func setupPresenter(id: Int) {
        presenter = MoviesInfoPresenter(view: self, id: id)
    }
    
    private func setupView() {
        view.backgroundColor = UIColor(named: Colors.background.name)
        setupTable()
        rightButton()
    }
    
    private func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MovieIconTableViewCell.self)
        tableView.register(MovieDetailsTableViewCell.self)
        tableView.backgroundColor = UIColor(named: Colors.background.name)
        tableView.separatorStyle = .none
    }
    
    private func rightButton() {
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
    }
    
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction private func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
            if let movieInfo = presenter.movieInfo {
                cell.display(entity: movieInfo)
                cell.backgroundColor = UIColor(named: Colors.background.name)
            }
            return cell
            // cell 2
        } else {
            let cell = tableView.dequeue(MovieDetailsTableViewCell.self, indexPath)
            if let movieInfo = presenter.movieInfo {
                cell.backgroundColor = UIColor(named: Colors.background.name)
                cell.display(entity: movieInfo)
            }
            return cell
        }
    }
}

extension MoviesInfoViewController: MoviesInfoViewControllerProtocol {
    func display(entity: MovieInfoEntity) {
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadTable(isAnimate: true)
        }
    }
}
