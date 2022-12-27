//
//  ColorPickerView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/20.
//

import SwiftUI

/// 아이콘을 만드는 뷰에서 사용하는 컬러 선택 뷰 입니다.
struct ColorPickerView: View {
    //  ===== User input =====
    @Binding var selectColor: Color?
    
    //  ===== About View =====
    /// 개발자가 추가한 색상 배열 입니다.
    var colorArray: [CustomColor] = CustomColor.colorArray
    /// HGrid의 행 개수를 위한 값으로 3줄로 구성되어있습니다.
    var colorRows: [GridItem] = .init(repeating: GridItem(.fixed(150/5),spacing: 10), count: 3)
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: colorRows) {
                ForEach(colorArray, id: \.id) { color in
                    Button {
                        //  컬러를 정할 시 재 클릭하면 nil를 대입하여 상위 뷰에서 nil에 대한 기댓값을 표현합니다.
                        self.selectColor = self.selectColor == color.color ? nil : color.color
                    }label: {
                        Circle()
                            .modifier(CustomCircleModifier(color:color.color, whiteLinePadding: 2.5, lineWidth: 3))
                    }
                }
            }
            .padding(.horizontal, 10)
        }
        .modifier(BackRoundedRecModifier(cornerValue: 8))
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
/// Hex String으로 Color와 String을 한번에 표현하기 위한 구조체 입니다.
class CustomColor {
    /// ForEach 문에서 Hashable 할당 대신 사용하기 위한 id 값 입니다.
    var id = UUID()
    /// Color 타입과 String 타입을 한번에 가지는 구조체를 배열로 사용하여 배열이 사용되는 뷰에서 두 값을 같이 쓰게합니다.
    static var colorArray: [CustomColor] = [.black, .gray, .red, .yellow, .green, .blue, .navy, .puple
                                            , .buttonBlue, .lightSeaGreen, .nickel, .marigold, princetonOrange, middleBluePurple]
    var color: Color
    var colorHex: String
    /**
     -  parameters:
        -   hex: Hexcode 로써 입력되면 내부 변수에 color와 hexString 값이 등록됩니다.
     */
    init(hex: String) {
        self.colorHex = hex
        self.color = .init(hex: colorHex)
    }
    //  MARK: - ICon Group
    //  기본색입니다.
    static var black: CustomColor = .init(hex: "000000")
    static var gray: CustomColor = .init(hex: "808080")
    static var white: CustomColor = .init(hex: "FFFFFF")
    static var red: CustomColor = .init(hex: "FF0000")
    static var yellow: CustomColor = .init(hex: "FFFF00")
    static var green: CustomColor = .init(hex: "008000")
    static var blue: CustomColor = .init(hex: "0000FF")
    static var navy: CustomColor = .init(hex: "000080")
    static var puple: CustomColor = .init(hex: "800080")
    //  개발자가 따로 추가하는 색입니다.
    static var lightGray: CustomColor = .init(hex: "F7F7F7")
    static var buttonBlue: CustomColor = .init(hex: "2da2e1")
    static var lightSeaGreen: CustomColor = .init(hex: "18acb6")
    static var nickel: CustomColor = .init(hex: "79716A")
    static var marigold: CustomColor = .init(hex: "f1a81a")
    static var princetonOrange: CustomColor = .init(hex: "f47d2e")
    static var middleBluePurple: CustomColor = .init(hex: "886cc4")
}
