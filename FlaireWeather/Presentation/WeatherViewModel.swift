//
//  WeatherViewModel.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import Foundation

public struct WeatherViewModel: Hashable {
    public let city: String
    public let temperature: String
    public let minMax: String
    public let state: String
    public let stateImgUrl: URL

    public init(city: String, temperature: String, minMax: String, state: String, stateImgUrl: URL) {
        self.city = city
        self.temperature = temperature
        self.minMax = minMax
        self.state = state
        self.stateImgUrl = stateImgUrl
    }
}
