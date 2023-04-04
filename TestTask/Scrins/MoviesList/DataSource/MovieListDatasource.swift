//
//  MovieListDatasource.swift
//  TestTask
//
//  Created by Yurii Honcharov on 04.04.2023.
//

import Foundation
import UIKit

protocol MovieListDataSourceProtocol {
    func display()
}

class MovieListDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
      var sections: [UpcomingApiEntity.Item] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(MovieListTableViewCell.self, indexPath)
//        cell.display(entity: presenter.movieUpcoming[indexPath.row])
        cell.backgroundColor = UIColor(named: Colors.background.name)
        // print(presenter.movieUpcoming[indexPath.row].id)
        // cell.infoLabel.text = String(indexPath.row)
//        if presenter.movieUpcoming.count - 1 == indexPath.row {
//            presenter.getData()
//        }
        return cell
    }
}
