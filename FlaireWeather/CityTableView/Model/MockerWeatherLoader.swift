//
//  MockerWeatherLoader.swift
//  FlaireWeather
//
//  Created by Fernando Luiz Goulart on 11/02/23.
//

import Foundation

public class MockedWeatherLoader: WorldWeatherLoader {

    @discardableResult
    public func fetchWeather(completion: @escaping (WorldWeatherLoader.Result) -> Void) -> WeatherLoaderTask? {
        var remoteCities: MockedRemoteWeatherList = MockedRemoteWeatherList(
            cities: [
                MockedRemoteCity(
                    country: "Canada",
                    weather: RemoteWeather(
                        location: "Winnipeg",
                        locationId: 1,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "Canada",
                    weather: RemoteWeather(
                        location: "Toronto",
                        locationId: 2,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "Brazil",
                    weather: RemoteWeather(
                        location: "São Paulo",
                        locationId: 3,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "Brazil",
                    weather: RemoteWeather(
                        location: "Brasília",
                        locationId: 4,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "Canada",
                    weather: RemoteWeather(
                        location: "Vancouver",
                        locationId: 4,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "Canada",
                    weather: RemoteWeather(
                        location: "Quebec",
                        locationId: 4,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "Canada",
                    weather: RemoteWeather(
                        location: "Calgary",
                        locationId: 4,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "Canada",
                    weather: RemoteWeather(
                        location: "Montreal",
                        locationId: 4,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "Canada",
                    weather: RemoteWeather(
                        location: "Halifax",
                        locationId: 4,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "Canada",
                    weather: RemoteWeather(
                        location: "Edmonton",
                        locationId: 4,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "Canada",
                    weather: RemoteWeather(
                        location: "Ottawa",
                        locationId: 4,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "Canada",
                    weather: RemoteWeather(
                        location: "Vitoria",
                        locationId: 4,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "Canada",
                    weather: RemoteWeather(
                        location: "Saskatoon",
                        locationId: 4,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "Brazil",
                    weather: RemoteWeather(
                        location: "Carapicuíba",
                        locationId: 4,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "Brazil",
                    weather: RemoteWeather(
                        location: "Poá",
                        locationId: 4,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "Brazil",
                    weather: RemoteWeather(
                        location: "Porto Alegre",
                        locationId: 4,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "Brazil",
                    weather: RemoteWeather(
                        location: "Curitiba",
                        locationId: 4,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "Brazil",
                    weather: RemoteWeather(
                        location: "Rio de Janeiro",
                        locationId: 4,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "Brazil",
                    weather: RemoteWeather(
                        location: "Niterói",
                        locationId: 4,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "Brazil",
                    weather: RemoteWeather(
                        location: "Belo Horizonte",
                        locationId: 4,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "Brazil",
                    weather: RemoteWeather(
                        location: "Jaú",
                        locationId: 4,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "Brazil",
                    weather: RemoteWeather(
                        location: "Limeira",
                        locationId: 4,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "Brazil",
                    weather: RemoteWeather(
                        location: "Vitória",
                        locationId: 4,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "Brazil",
                    weather: RemoteWeather(
                        location: "Florianópolis",
                        locationId: 4,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "Brazil",
                    weather: RemoteWeather(
                        location: "São Luís",
                        locationId: 4,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "Brazil",
                    weather: RemoteWeather(
                        location: "Fortaleza",
                        locationId: 4,
                        timezone: "",
                        consolidatedWeather: []
                    )
                )
            ]
        )
        remoteCities.cities.sort { lhs, rhs in
            guard lhs.country != rhs.country else {
                return lhs.weather.location <= rhs.weather.location
            }
            return lhs.country <= rhs.country
        }

        var mockedList: [(String, [CityWeather])] = []

        var previousCountry = ""
        var previousContryCities: [CityWeather] = []
        for city in remoteCities.cities {
            if city.country != previousCountry {
                if !previousCountry.isEmpty {
                    mockedList.append((previousCountry, previousContryCities))
                }
                previousContryCities = [
                    CityWeather(
                        cityName: city.weather.location,
                        temperature: 1,
                        minimum: 1,
                        maximum: 1,
                        state: "",
                        stateImgUrl: ""
                    )
                ]
            } else {
                previousContryCities.append(
                    CityWeather(
                        cityName: city.weather.location,
                        temperature: 1,
                        minimum: 1,
                        maximum: 1,
                        state: "",
                        stateImgUrl: ""
                    )
                )
            }
            previousCountry = city.country
        }
        if !previousCountry.isEmpty {
            mockedList.append((previousCountry, previousContryCities))
        }
        completion(.success(mockedList))
        return nil
    }
}

extension WorldWeatherLoader {
    @discardableResult
    public func fetchMoreWeather(completion: @escaping (WorldWeatherLoader.Result) -> Void) -> WeatherLoaderTask? {
        var remoteCities: MockedRemoteWeatherList = MockedRemoteWeatherList(
            cities: [
                MockedRemoteCity(
                    country: "USA",
                    weather: RemoteWeather(
                        location: "Washington",
                        locationId: 31,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "USA",
                    weather: RemoteWeather(
                        location: "New York",
                        locationId: 32,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "USA",
                    weather: RemoteWeather(
                        location: "Orlando",
                        locationId: 33,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "USA",
                    weather: RemoteWeather(
                        location: "Miami",
                        locationId: 34,
                        timezone: "",
                        consolidatedWeather: []
                    )
                ),
                MockedRemoteCity(
                    country: "USA",
                    weather: RemoteWeather(
                        location: "Los Angeles",
                        locationId: 35,
                        timezone: "",
                        consolidatedWeather: []
                    )
                )
            ]
        )
        remoteCities.cities.sort { lhs, rhs in
            guard lhs.country != rhs.country else {
                return lhs.weather.location <= rhs.weather.location
            }
            return lhs.country <= rhs.country
        }

        var mockedList: [(String, [CityWeather])] = []

        var previousCountry = ""
        var previousContryCities: [CityWeather] = []
        for city in remoteCities.cities {
            if city.country != previousCountry {
                if !previousCountry.isEmpty {
                    mockedList.append((previousCountry, previousContryCities))
                }
                previousContryCities = [
                    CityWeather(
                        cityName: city.weather.location,
                        temperature: 1,
                        minimum: 1,
                        maximum: 1,
                        state: "",
                        stateImgUrl: ""
                    )
                ]
            } else {
                previousContryCities.append(
                    CityWeather(
                        cityName: city.weather.location,
                        temperature: 1,
                        minimum: 1,
                        maximum: 1,
                        state: "",
                        stateImgUrl: ""
                    )
                )
            }
            previousCountry = city.country
        }
        if !previousCountry.isEmpty {
            mockedList.append((previousCountry, previousContryCities))
        }
        completion(.success(mockedList))
        return nil
    }
}
