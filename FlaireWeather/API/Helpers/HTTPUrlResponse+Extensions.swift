//
//  HTTPUrlResponse+Extensions.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import Foundation

extension HTTPURLResponse {
    
    var isOK: Bool {
        switch self.statusCode {
        case 200...299: return true
        case 403: return true
        default: return false
        }
    }
}
