//
//  ViewController.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import UIKit
import SwiftUI

public final class CityWeatherViewController: UIViewController {

    var selectedCityId: Int
    public var weatherView: CityWeatherUIView
    public var refreshControl: CityWeatherRefreshControl

    public init(selectedCityId: Int = 4418, refreshControl: CityWeatherRefreshControl = CityWeatherRefreshControl()) {
        self.selectedCityId = selectedCityId
        self.refreshControl = refreshControl
        refreshControl.selectedCityId = selectedCityId
        self.weatherView = CityWeatherUIView(refreshControl: refreshControl)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view = weatherView
        refreshControl.didPullToRefresh()
    }
}


public final class CityWeatherRefreshControl: UIRefreshControl, WeatherLoadingView {

    public var selectedCityId: Int = -1
    var delegate: CityWeatherDelegate?

    public func display(_ viewModel: WeatherLoadingViewModel) {
        switch viewModel.isLoading {
        case true:
            DispatchQueue.main.async {
                self.beginRefreshing()
            }
        case false:
            DispatchQueue.main.async {
                self.endRefreshing()
            }
        }
    }

    override public init() {
        super.init()
        self.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    func didPullToRefresh() {
        delegate?.didRequestWeather(for: selectedCityId)
    }
}

struct CityWeatherViewControllerPreviews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            CityWeatherViewController()
        }
    }
}
