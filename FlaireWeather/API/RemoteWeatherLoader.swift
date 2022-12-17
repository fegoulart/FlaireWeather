//
//  RemoteWeatherLoader.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import Foundation

public final class RemoteWeatherLoader: WeatherLoader {

    private let baseUrl: String
    private let client: HTTPClient

    public init(baseUrl: String, client: HTTPClient) {
        self.baseUrl = baseUrl
        self.client = client
    }

    private final class HTTPClientTaskWrapper: WeatherLoaderTask {
        private var completion: ((WeatherLoader.Result) -> Void)?

        var wrapped: HTTPClientTask?

        init(_ completion: @escaping (WeatherLoader.Result) -> Void) {
            self.completion = completion
        }

        func complete(with result: WeatherLoader.Result) {
            completion?(result)
        }

        func cancel() {
            preventFurtherCompletions()
            wrapped?.cancel()
        }

        private func preventFurtherCompletions() {
            completion = nil
        }
    }

    @discardableResult
    public func fetchWeather(for cityId: Int, completion: @escaping (WeatherLoader.Result) -> Void) -> WeatherLoaderTask? {
        let task = HTTPClientTaskWrapper(completion)

        let updatedUrl = "\(baseUrl)/\(cityId).json"
        guard let url = URL(string: updatedUrl) else { completion(.failure(.invalidWeatherUrl));  return nil }

        let urlRequest = URLRequest(url: url)
        task.wrapped = client.get(from: urlRequest) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case let .success((data, response)):
                guard let weather = try? RemoteWeather.map(data,from: response), let cityWeather: CityWeather = try? RemoteWeather.map(weather)  else {
                    completion(.failure(WeatherLoaderError.invalidData))
                    return
                }
                completion(.success(cityWeather))
            case .failure:
                completion(.failure(WeatherLoaderError.networkError))
            }
        }
        return task
    }
}

