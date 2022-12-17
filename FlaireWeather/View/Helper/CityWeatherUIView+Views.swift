//
//  CityWeatherUIView+Views.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import Foundation

extension CityWeatherUIView: WeatherLoadingView {
    public func display(_ viewModel: WeatherLoadingViewModel) {
        switch viewModel.isLoading {
        case true:
            DispatchQueue.main.async {
                self.refreshControl.beginRefreshing()
            }
        case false:
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
            }
        }
    }
}
