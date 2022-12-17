//
//  HTTPClient.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import Foundation

public protocol HTTPClientTask {
    func cancel()
}

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>

    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func get(
        from request: URLRequest,
        completion: @escaping (Result) -> Void
    ) -> HTTPClientTask

    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func get(
        from request: URLRequest
    ) -> Result

}
