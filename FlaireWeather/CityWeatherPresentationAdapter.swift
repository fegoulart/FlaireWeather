//
//  CityWeatherPresentationAdapter.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import Foundation

final class CityWeatherPresentationAdapter: CityWeatherDelegate {

    let cityWeatherPresenter: CityWeatherPresenter
    let weatherLoader: WeatherLoader

    init(
        cityWeatherPresenter: CityWeatherPresenter,
        weatherLoader: WeatherLoader
    ) {
        self.cityWeatherPresenter = cityWeatherPresenter
        self.weatherLoader = weatherLoader
    }

    func didRequestWeather(for cityId: Int) {
        cityWeatherPresenter.didStartLoading()
        weatherLoader.fetchWeather(for: cityId) { result in
            switch result {
            case .success(let weather):
                cityWeatherPresenter.didFinishLoading(with: weather)
            case .failure(let error):
                cityWeatherPresenter.didFinishLoading(with: error)
            }
        }
    }

    deinit {
        print("PRESENTATION ADAPTER MORREU")
    }

}
