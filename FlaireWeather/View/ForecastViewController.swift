//
//  ForecastViewController.swift
//  FlaireWeather
//
//  Created by Fernando Luiz Goulart on 14/02/23.
//

import Foundation
import UIKit

class ForecastViewController: UITableViewController {

    var tableData: [DayWeather]

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    }
}

extension ForecastViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {

    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

    }
}

class ForecastTableCell: UITableViewCell {


}
