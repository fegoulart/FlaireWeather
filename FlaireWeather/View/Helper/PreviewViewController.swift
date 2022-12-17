//
//  PreviewViewController.swift
//  FlaireWeather
//
//  Copyright © 2022 Leapi. All rights reserved.
//

import UIKit
import SwiftUI

struct ViewControllerPreview: UIViewControllerRepresentable {

    let viewControllerBuilder: () -> UIViewController

    init(_ viewControllerBuilder: @escaping () -> UIViewController) {
        self.viewControllerBuilder = viewControllerBuilder
    }

    func makeUIViewController(context: Context) -> some UIViewController {
        return viewControllerBuilder()
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
}
