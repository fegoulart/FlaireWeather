//
//  WeatherErrorViewModel.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import Foundation

public struct WeatherErrorViewModel {
    public let message: String?

    static var noError: WeatherErrorViewModel {
        return WeatherErrorViewModel(message: nil)
    }

    static func error(message: String) -> WeatherErrorViewModel {
        return WeatherErrorViewModel(message: message)
    }
}
