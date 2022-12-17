//
//  ViewCodeProtocol.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import Foundation

protocol ViewCodeProtocol {

    func setupHierarchy()
    func setupConstraints()
    func additionalSetup()
    func buildView()
}

extension ViewCodeProtocol {

    func buildView() {
        setupHierarchy()
        setupConstraints()
        additionalSetup()
    }

    func setupConstraints() { }
    func additionalSetup() { }
}
