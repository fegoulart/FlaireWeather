//
//  CityWeatherViewController+Views.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import Foundation

extension CityWeatherViewController: WeatherView {
    func display(_ viewModel: WeatherViewModel) {
        weatherView.cityNameUILabel.text = viewModel.city
        weatherView.temperature.text = viewModel.temperature
        weatherView.lowHighUILabel.text = viewModel.minMax
        weatherView.statusUILabel.text = viewModel.state
    }
}

extension CityWeatherViewController: WeatherErrorView {
    func display(_ viewModel: WeatherErrorViewModel) {
        guard let message = viewModel.message, !message.isEmpty else {
            weatherView.errorViewLabel.text = ""
            weatherView.errorViewLabel.isHidden = true
            return
        }
        weatherView.errorViewLabel.text = message
        weatherView.errorViewLabel.isHidden = false
    }
}

extension CityWeatherViewController: WeatherLoadingView {
    func display(_ viewModel: WeatherLoadingViewModel) {
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
