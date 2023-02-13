//
//  CitiesTableViewController.swift
//  FlaireWeather
//
//  Created by Fernando Luiz Goulart on 11/02/23.
//

import UIKit
import SwiftUI

public protocol CitiesTableDelegate {
    func didSelect(woeid: Int)
}

public final class CitiesTableViewController: UITableViewController {

    // When you initialize the table view controller, you must specify the style of the table view (plain or grouped). You must also override the data source and delegate methods required to fill your table with data. You may override loadView() or any other superclass method, but if you do, be sure to invoke the superclass implementation of the method, usually as the first method call./

    var delegate: CitiesTableDelegate
    var tableData: WorldWeatherLoader.WeatherListData = []
    let fetchWeather: (@escaping (WorldWeatherLoader.Result) -> Void) -> Void
    let fetchMoreWeather: (@escaping (WorldWeatherLoader.Result) -> Void) -> Void
    private let cellReuseId = "weatherListCell"

    public override func viewDidLoad() {
        tableView.prefetchDataSource = self
        tableView.isPrefetchingEnabled = true
        tableView.dataSource = self
        refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.register(WeatherTableCell.self, forCellReuseIdentifier: cellReuseId)
        didPullToRefresh()
        tableView.rowHeight = 40
        super.viewDidLoad()
    }

    public init(
        fetchWeather: @escaping (@escaping (Result<WorldWeatherLoader.WeatherListData, WeatherLoaderError>) -> Void) -> Void,
        fetchMoreWeather: @escaping (@escaping (Result<WorldWeatherLoader.WeatherListData, WeatherLoaderError>) -> Void) -> Void,
        delegate: CitiesTableDelegate
    ) {
        self.fetchWeather = fetchWeather
        self.fetchMoreWeather = fetchMoreWeather
        self.delegate = delegate
        super.init(style: .insetGrouped)
    }

    @objc
    func didPullToRefresh() {
        DispatchQueue.main.async {
            self.refreshControl?.beginRefreshing()
        }
        self.fetchWeather { result in
            DispatchQueue.main.async {
                if case .success(let data) = result {
                    self.tableData = data
                    self.tableView.reloadData()
                }
                self.refreshControl?.endRefreshing()
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewWillAppear(_ animated: Bool) {
        // automatically reloads the data for its table view on first appearance, and clears its selection (with or without animation, depending on the request) every time the table view appears (disable this last behavior by changing the value of clearsSelectionOnViewWillAppear)
        super.viewWillAppear(animated)
    }

    public override func viewDidAppear(_ animated: Bool) {
        // automatically flashes the table view’s scroll indicators when it first appears
        super.viewDidAppear(animated)

    }

    public override func setEditing(_ editing: Bool, animated: Bool) {
        // automatically toggles the edit mode of the table when the user taps an Edit|Done button in the navigation bar
        super.setEditing(editing, animated: animated)
    }
}

// UITableViewDataSource
extension CitiesTableViewController {

    public override func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < tableData.count else { return 0 }
        return tableData[section].1.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseId, for: indexPath) as? WeatherTableCell else { return UITableViewCell() }
        let city: CityWeather = tableData[indexPath.section].1[indexPath.row]
        let cellViewData = WeatherCellViewData(
            cityName: city.cityName,
            currentTemp: String(city.temperature),
            imageUrl: city.stateImgUrl
        )
        cell.viewData = cellViewData
        cell.refreshCell()
        return cell
    }

    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section < tableData.count else { return }
        let city = tableData[indexPath.section].1[indexPath.row]
        delegate.didSelect(woeid: 4118)
        print("Selecionou \(city.cityName)")
    }

    public override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section < tableData.count else { return nil }
        return tableData[section].0
    }
}

// Prefetching
extension CitiesTableViewController:  UITableViewDataSourcePrefetching {
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            print("prefetch section \(indexPath.section) - row \(indexPath.row)")
            if indexPath.section == tableData.count-1 && indexPath.row == tableData[indexPath.section].1.count-1 {
                self.fetchMoreWeather { result in
                    DispatchQueue.main.async {
                        if case .success(let data) = result {
                            self.tableData = self.tableData + data
                            self.tableView.reloadData()
                        }
                        self.refreshControl?.endRefreshing()
                    }
                }
            }
        }
    }

    public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            print("CANCEL prefetch section \(indexPath.section) - row \(indexPath.row)")
        }
    }
}

//struct CitiesTableViewControllerPreviews: PreviewProvider {
//    static var previews: some View {
//        ViewControllerPreview {
//            CitiesTableViewController(weatherLoader: RemoteWeatherLoader(baseUrl: "", client: URLSessionHTTPClient()))
//        }
//    }
//}
