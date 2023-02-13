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
    case invalidWeatherUrl
    case invalidData
}

public protocol WeatherLoaderTask {
    func cancel()
}

public protocol WeatherLoader {
    typealias Result = Swift.Result<CityWeather, WeatherLoaderError>

    @discardableResult
    func fetchWeather(for cityId: Int, completion: @escaping (Result) -> Void) -> WeatherLoaderTask?
}

public protocol WorldWeatherLoader {
    typealias Result = Swift.Result<WeatherListData, WeatherLoaderError>
    typealias WeatherListData = [(String, [CityWeather])]

    @discardableResult
    func fetchWeather(completion: @escaping (Result) -> Void) -> WeatherLoaderTask?

    @discardableResult
    func fetchMoreWeather(completion: @escaping (Result) -> Void) -> WeatherLoaderTask?
}
