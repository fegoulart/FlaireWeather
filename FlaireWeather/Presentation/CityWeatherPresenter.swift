//
//  CityWeatherPresenter.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import Foundation

final class CityWeatherPresenter {
    let weatherView: WeatherView
    let weatherErrorView: WeatherErrorView
    let weatherLoadingView: WeatherLoadingView

    init(
        weatherView: WeatherView,
        weatherErrorView: WeatherErrorView,
        weatherLoadingView: WeatherLoadingView
    ) {
        self.weatherView = weatherView
        self.weatherErrorView = weatherErrorView
        self.weatherLoadingView = weatherLoadingView
    }

    func didStartLoading() {
        weatherErrorView.display(.noError)
        weatherLoadingView.display(WeatherLoadingViewModel(isLoading: true))
    }

    func didFinishLoading(with weather: CityWeather) {
        weatherLoadingView.display(WeatherLoadingViewModel(isLoading: false))
        weatherView.display(map(weather))
    }

    func didFinishLoading(with error: WeatherLoaderError) {
        weatherLoadingView.display(WeatherLoadingViewModel(isLoading: false))
        weatherErrorView.display(map(error))
    }

    func map(_ weather: CityWeather) -> WeatherViewModel {
        return WeatherViewModel(
            city: "São Paulo",
            temperature: "25º",
            minMax: "L: 20º H: 27º",
            state: "Light Cloud",
            stateImgUrl: URL(string: "https://cdn.faire.com/static/mobile-take-home/icons/lc.png")!
        )
    }

    func map(_ error: WeatherLoaderError) -> WeatherErrorViewModel {
        switch error {
        case .networkError:
            return WeatherErrorViewModel(message: "Could not fetch weather. Please try again later.")
        }
    }

    deinit {
        print("PRESENTER MORREU")
    }
}
