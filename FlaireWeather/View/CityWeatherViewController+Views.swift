//
//  CityWeatherViewController+Views.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import Foundation

extension CityWeatherViewController: WeatherView {
    public func display(_ viewModel: WeatherViewModel) {
        weatherView.cityNameUILabel.text = viewModel.city
        weatherView.temperature.text = viewModel.temperature
        weatherView.lowHighUILabel.text = viewModel.minMax
        weatherView.statusUILabel.text = viewModel.state
    }
}

extension CityWeatherViewController: WeatherErrorView {
    public func display(_ viewModel: WeatherErrorViewModel) {
        guard let message = viewModel.message, !message.isEmpty else {
            weatherView.errorViewLabel.text = ""
            weatherView.errorViewLabel.isHidden = true
            return
        }
        weatherView.errorViewLabel.text = message
        weatherView.errorViewLabel.isHidden = false
    }
}
