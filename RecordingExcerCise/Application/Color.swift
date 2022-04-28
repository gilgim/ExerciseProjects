//
//  Color.swift
//  SWprojecte
//
//  Created by KimWooJin on 2022/02/07.
//

import Foundation
import SwiftUI

extension Color {
    init(hex : String){
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        var rgb : UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double((rgb >> 0) & 0xFF) / 255
        self.init(red: r, green: g, blue: b)
    }
    
    //  추가되는 헥사코드 설정.
    static let dividerColor = Color(hex: "333232")
    
    //  개인정보 버튼 색상
    static let buttonColor = Color(hex: "EAEAEB")
    static let buttonSelecColor = Color(hex: "5C5C68")
    
    //  개인정보 입력 완료
    static let userCompleteColor = Color(hex: "A4A4D7")
}

extension UIColor {
    convenience init(hex : String){
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        var rgb : UInt64 = 0
        scanner.scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double((rgb >> 0) & 0xFF) / 255
        self.init(red: r, green: g, blue: b, alpha: 1)
    }

    //  추가되는 헥사코드 설정.
    static let dividerColor = UIColor(hex: "333232")
    
    //  개인정보 버튼 색상
    static let buttonColor = UIColor(hex: "EAEABE")
    static let buttonSelecColor = UIColor(hex: "5C5C68")
    
    //  개인정보 입력 완료
    static let userCompleteColor = UIColor(hex: "A4A4D7")
}
