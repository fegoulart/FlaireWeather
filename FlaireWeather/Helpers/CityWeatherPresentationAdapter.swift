//
//  CityWeatherPresentationAdapter.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import Foundation

final public class CityWeatherPresentationAdapter: CityWeatherDelegate {

    let cityWeatherPresenter: CityWeatherPresenter
    let weatherLoader: WeatherLoader

    public init(
        cityWeatherPresenter: CityWeatherPresenter,
        weatherLoader: WeatherLoader
    ) {
        self.cityWeatherPresenter = cityWeatherPresenter
        self.weatherLoader = weatherLoader
    }

    public func didRequestWeather(for cityId: Int) {
        cityWeatherPresenter.didStartLoading()
        _ = weatherLoader.fetchWeather(for: cityId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let weather):
                self.cityWeatherPresenter.didFinishLoading(with: weather)
            case .failure(let error):
                self.cityWeatherPresenter.didFinishLoading(with: error)
            }
        }
    }
}
