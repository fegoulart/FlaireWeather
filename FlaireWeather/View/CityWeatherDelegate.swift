//
//  CityWeatherDelegate.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import Foundation

protocol CityWeatherDelegate: AnyObject {
    func didRequestWeather(for cityId: Int)
}
