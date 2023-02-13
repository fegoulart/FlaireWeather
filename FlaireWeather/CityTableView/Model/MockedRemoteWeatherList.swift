//
//  MockedRemoteWeatherList.swift
//  FlaireWeather
//
//  Created by Fernando Luiz Goulart on 11/02/23.
//

import Foundation

public struct MockedRemoteWeatherList: Decodable {
    public var cities: [MockedRemoteCity]
}

public struct MockedRemoteCity: Decodable {
    public var country: String
    public var weather: RemoteWeather
}
