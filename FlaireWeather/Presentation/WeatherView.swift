//
//  WeatherView.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import Foundation

public protocol WeatherView {
    func display(_ viewModel: WeatherViewModel)
}
