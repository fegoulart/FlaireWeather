//
//  CityWeather.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import Foundation

public struct CityWeather: Hashable {
    let cityName: String
    let temperature: Int
    let minimum: Int
    let maximum: Int
    let state: String
    let stateImgUrl: String

    public init(cityName: String, temperature: Int, minimum: Int, maximum: Int, state: String, stateImgUrl: String) {
        self.cityName = cityName
        self.temperature = temperature
        self.minimum = minimum
        self.maximum = maximum
        self.state = state
        self.stateImgUrl = stateImgUrl
    }
}
