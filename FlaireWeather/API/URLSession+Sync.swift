//
//  URLSession+Sync.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import Foundation

extension URLSession {

    // swiftlint:disable:next large_tuple
    func syncRequest(with url: URL) -> (Data?, URLResponse?, Error?) {
        var data: Data?
        var response: URLResponse?
        var error: Error?

        let dispatchGroup = DispatchGroup()
        let task = dataTask(with: url) {
            data = $0
            response = $1
            error = $2
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        task.resume()
        dispatchGroup.wait()

        return (data, response, error)
    }

    // swiftlint:disable:next large_tuple
    func syncRequest(with request: URLRequest) -> (Data?, URLResponse?, Error?) {
        var data: Data?
        var response: URLResponse?
        var error: Error?

        let dispatchGroup = DispatchGroup()
        let task = dataTask(with: request) {
            data = $0
            response = $1
            error = $2
            dispatchGroup.leave()
        }
        dispatchGroup.enter()
        task.resume()
        dispatchGroup.wait()

        return (data, response, error)
    }
}

