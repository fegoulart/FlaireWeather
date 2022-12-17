//
//  RemoteWeather.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import Foundation

public struct RemoteWeather {
    public var location: String
    public var locationId: Int
    public var timezone: String
    public var consolidatedWeather: [ DayWeather ]
}

extension RemoteWeather: Decodable {
    enum CodingKeys: String, CodingKey {
        case location = "title"
        case locationId = "woeid"
        case timezone = "timezone"
        case consolidatedWeather = "consolidated_weather"
    }
}

public struct DayWeather {
    public var state: String
    public var stateId: String
    public var day: String
    public var min: Double
    public var max: Double
    public var temperature: Double
}

extension DayWeather: Decodable {
    enum CodingKeys: String, CodingKey {
        case state = "weather_state_name"
        case stateId = "weather_state_abbr"
        case day = "applicable_date"
        case min = "min_temp"
        case max = "max_temp"
        case temperature = "the_temp"
    }
}

extension RemoteWeather {
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> RemoteWeather {
        guard response.isOK, let weather = try? JSONDecoder().decode(RemoteWeather.self, from: data) else {
            throw WeatherLoaderError.invalidData
        }
        return weather
    }

    public static func map(_ remoteWeather: RemoteWeather) throws -> CityWeather {
        guard !remoteWeather.consolidatedWeather.isEmpty else { throw WeatherLoaderError.invalidData }
        guard let remoteDayWeather: DayWeather = extractCorrectWeather(remoteWeather) else { throw WeatherLoaderError.invalidData }
        return CityWeather(
            cityName: remoteWeather.location,
            temperature: Int(round(remoteDayWeather.temperature)),
            minimum: Int(round(remoteDayWeather.min)),
            maximum: Int(round(remoteDayWeather.max)),
            state: remoteDayWeather.state,
            stateImgUrl: "https://cdn.faire.com/static/mobile-take-home/icons/\(remoteDayWeather.stateId).png"
        )
    }

    private static func extractCorrectWeather(_ remoteWeather: RemoteWeather) -> DayWeather? {
        guard remoteWeather.consolidatedWeather.count > 0 else { return nil }
        return remoteWeather.consolidatedWeather.randomElement()
    }
}
