//
//  CityWeatherPresenter.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import Foundation

public final class CityWeatherPresenter {
    let weatherView: WeatherView
    let weatherErrorView: WeatherErrorView
    let weatherLoadingView: WeatherLoadingView

    public init(
        weatherView: WeatherView,
        weatherErrorView: WeatherErrorView,
        weatherLoadingView: WeatherLoadingView
    ) {
        self.weatherView = weatherView
        self.weatherErrorView = weatherErrorView
        self.weatherLoadingView = weatherLoadingView
    }

    public func didStartLoading() {
        weatherErrorView.display(.noError)
        weatherLoadingView.display(WeatherLoadingViewModel(isLoading: true))
    }

    public func didFinishLoading(with weather: CityWeather) {
        weatherLoadingView.display(WeatherLoadingViewModel(isLoading: false))
        do {
            weatherView.display(try map(weather))
        } catch {

        }
    }

    public func didFinishLoading(with error: WeatherLoaderError) {
        weatherLoadingView.display(WeatherLoadingViewModel(isLoading: false))
        weatherErrorView.display(map(error))
    }

    func map(_ weather: CityWeather) throws -> WeatherViewModel {
        guard let stateUrl: URL = URL(string: weather.stateImgUrl) else {
            throw WeatherLoaderError.invalidImageStateUrl
        }

        return WeatherViewModel(
            city: weather.cityName,
            temperature: "\(weather.temperature)º",
            minMax: "L: \(weather.minimum)º H: \(weather.maximum)º",
            state: weather.state,
            stateImgUrl: stateUrl
        )
    }

    func map(_ error: WeatherLoaderError) -> WeatherErrorViewModel {
        switch error {
        case .networkError:
            return WeatherErrorViewModel(message: "Could not fetch weather. Please try again later.")
        case .invalidImageStateUrl:
            return WeatherErrorViewModel(message: "Invalid weather data")
        }
    }

    deinit {
        print("PRESENTER MORREU")
    }
}
