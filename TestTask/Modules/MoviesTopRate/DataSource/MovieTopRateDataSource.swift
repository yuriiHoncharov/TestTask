//
//  MovieTopRateDataSource.swift
//  TestTask
//
//  Created by Yurii Honcharov on 05.04.2023.
//

import UIKit

class MovieTopRateDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    private var rows: [MovieEntity] = []
    var didSelectRowAt: ((_ indexPath: IndexPath) -> Void)?
    var loadMoreItem: (() -> Void)?
    
    func updateData(rows: [MovieEntity]) {
        self.rows = rows
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = rows[indexPath.row]
        let cell: UITableViewCell & MovieListTableViewCellProtocol = tableView.dequeue(MovieListTableViewCell.self, indexPath)
        
        cell.display(entity: item)
        
        if rows.count - 1 == indexPath.row {
            loadMoreItem?()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowAt?(indexPath)
    }
}
