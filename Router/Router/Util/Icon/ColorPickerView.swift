//
//  ColorPickerView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/20.
//

import SwiftUI

/// -   Korean :    색상을 선택할 수 있는 색상 선택 뷰
/// -   English :
struct ColorPickerView: View {
    //  MARK: - User Input
    /// -   Korean :    유저가 선택한 색상
    /// -   English :
    @Binding var selectColor: Color?
    //  MARK: - About View
    /// -  개발자가 추가한 색상 배열
    var colorArray: [CustomColor] = CustomColor.colorArray
    /// -  Grid 뷰에서 행, 또는 열 개수의 대한 값이 배열의 개수로 정해진다.
    var colorRows: [GridItem] = .init(repeating: GridItem(.fixed(150/5),spacing: 10), count: 3)
    
    var body: some View {
        /// -   추가확장을 위한 스크롤 뷰
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: colorRows) {
                ForEach(colorArray, id: \.id) { color in
                    Button {
                        self.selectColor = self.selectColor == color.color ? nil : color.color
                    }label: {
                        Circle()
                            .modifier(CustomCircleModifier(color:color.color, lineCirclePadding: 2.5, lineWidth: 3))
                    }
                }
            }
            .padding(.horizontal, 10)
        }
        .modifier(BackRoundedRecModifier(cornerValue: 8))
        //  -   컬러 픽커의 크기
        .frame(height: 150)
        .padding(.horizontal, 10)
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView(selectColor: .constant(.clear))
    }
}
//  MARK: - Structs
/// -   Korean :    Color 색상 값을 텍스로 받기위한 구조체
/// -   English :
class CustomColor {
    /// -   ForEach 의 id 로 사용하기 위한 UUID.
    var id = UUID()
    /// -   Korean :    뷰와 데이터 모두 사용하기 위한 배열 값
    /// -   English :
    static var colorArray: [CustomColor] = [.black, .gray, .red, .yellow, .green, .blue, .navy, .puple
                                            , .buttonBlue, .lightSeaGreen, .nickel, .marigold, princetonOrange, middleBluePurple]
    var color: Color
    var colorHex: String
    //  -   초기화 시 String 값만으로 image까지 할당한다.
    init(hex: String) {
        self.colorHex = hex
        self.color = .init(hex: colorHex)
    }
    //  MARK: - ICon Group
    // * 색상 모음 *
    //  -   기본색
    static var black: CustomColor = .init(hex: "000000")
    static var gray: CustomColor = .init(hex: "808080")
    static var white: CustomColor = .init(hex: "FFFFFF")
    static var red: CustomColor = .init(hex: "FF0000")
    static var yellow: CustomColor = .init(hex: "FFFF00")
    static var green: CustomColor = .init(hex: "008000")
    static var blue: CustomColor = .init(hex: "0000FF")
    static var navy: CustomColor = .init(hex: "000080")
    static var puple: CustomColor = .init(hex: "800080")

    //  -   개발자 추가색
    static var lightGray: CustomColor = .init(hex: "F7F7F7")
    static var buttonBlue: CustomColor = .init(hex: "2da2e1")
    static var lightSeaGreen: CustomColor = .init(hex: "18acb6")
    static var nickel: CustomColor = .init(hex: "79716A")
    static var marigold: CustomColor = .init(hex: "f1a81a")
    static var princetonOrange: CustomColor = .init(hex: "f47d2e")
    static var middleBluePurple: CustomColor = .init(hex: "886cc4")
}
