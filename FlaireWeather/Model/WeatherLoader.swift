//
//  WeatherLoader.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import Foundation

public enum WeatherLoaderError: Error {
    case networkError
    case invalidImageStateUrl
}

public protocol WeatherLoader {
    func fetchWeather(for cityId: Int, completion: @escaping (Result<CityWeather, WeatherLoaderError>) -> Void)
}

public final class RemoteWeatherLoader: WeatherLoader {

    public init() {}

    public func fetchWeather(for cityId: Int, completion: (Result<CityWeather, WeatherLoaderError>) -> Void) {
        let weather = CityWeather(
            cityName: "Rio de Janeiro",
            temperature: 40,
            minimum: 25,
            maximum: 41,
            state: "Light Cloud",
            stateImgUrl: "https://cdn.faire.com/static/mobile-take-home/icons/lc.png"
        )
        completion(.success(weather))
    }
}
