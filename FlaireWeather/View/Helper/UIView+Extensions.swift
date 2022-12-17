//
//  UIView+Extensions.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import UIKit

extension UIView {

    func constraint(_ closure: (UIView) -> [NSLayoutConstraint]) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(closure(self))
    }
}
