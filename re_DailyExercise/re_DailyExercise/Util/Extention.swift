//
//  Extention.swift
//  re_DailyExercise
//
//  Created by KimWooJin on 2022/08/26.
//

import Foundation
import SwiftUI

extension View {
}

extension Color {
    init(hex : String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        var rgb : UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double((rgb >> 0) & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
    static let safeTopBottomColor = Color(hex: "e5e3ee")
    static let safeMainColor = Color(hex: "efedf4")
    static let searchBarColor = Color(hex: "dcdbe2")
    static let fixObjectColor = Color(hex: "eeeefc")
    static let almostFontColor = Color(hex: "8484c2")
    static let almostShadowColor = Color(hex: "BCBDE1")
    static let buttonFontBlack = Color(hex: "6d6d77")
    static let buttonSelectColor = Color(hex: "a4a4d7")
    static let buttonSelectBackColor = Color(hex: "f9f7ff")
    static let buttonDisableGray = Color(hex: "c2c2c7")
    static let cancelRed = Color(hex: "ff3b2f")
}

extension UIColor {
    convenience init(hex : String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        var rgb : UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double((rgb >> 0) & 0xFF) / 255
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    static var disableScroll: Bool = false
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if  UINavigationController.disableScroll {
            return false
        }
        else {
            return viewControllers.count > 1
        }
    }
}
