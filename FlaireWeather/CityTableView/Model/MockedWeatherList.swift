//
//  MockedWeatherList.swift
//  FlaireWeather
//
//  Created by Fernando Luiz Goulart on 11/02/23.
//

import Foundation

public struct MockedWeatherList {
    public var cities: [MockedCity]
}

public struct MockedCity {
    public var country: String
    public var city: String
    public var weather: CityWeather
}
