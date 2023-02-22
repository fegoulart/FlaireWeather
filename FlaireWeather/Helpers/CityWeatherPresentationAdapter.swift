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
    let navigateToForecast: (CityWeather) -> ()

    public init(
        cityWeatherPresenter: CityWeatherPresenter,
        weatherLoader: WeatherLoader,
        navigateToForecast: @escaping (CityWeather) -> ()
    ) {
        self.cityWeatherPresenter = cityWeatherPresenter
        self.weatherLoader = weatherLoader
        self.navigateToForecast = navigateToForecast
    }

    public func didRequestWeather(for cityId: Int) {
        cityWeatherPresenter.didStartLoading()
        DispatchQueue.global().async {
            _ = self.weatherLoader.fetchWeather(for: cityId) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let weather):
                        self.cityWeatherPresenter.didFinishLoading(with: weather)
                    case .failure(let error):
                        self.cityWeatherPresenter.didFinishLoading(with: error)
                    }
                }
            }
        }
    }
}

extension CityWeatherPresentationAdapter: CityForecastDelegate {
    public func didRequestForecast(for cityId: Int) {
        DispatchQueue.global().async {
            _ = self.weatherLoader.fetchWeather(for: cityId) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let weather):
                        self.navigateToForecast(weather)
                    case .failure(let error):
                        self.cityWeatherPresenter.didFinishLoading(with: error)
                    }
                }
            }
        }
    }
}
