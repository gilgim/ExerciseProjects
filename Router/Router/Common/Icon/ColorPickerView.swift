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
    var colorArray: [Color?] = Color.colors
    /// -  Grid 뷰에서 행, 또는 열 개수의 대한 값이 배열의 개수로 정해진다.
    var colorRows: [GridItem] = .init(repeating: GridItem(.fixed(150/5),spacing: 10), count: 3)
    
    var body: some View {
        /// -   추가확장을 위한 스크롤 뷰
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: colorRows) {
                ForEach(colorArray, id: \.self) { color in
                    Button {
                        self.selectColor = self.selectColor == color ? nil : color
                    }label: {
                        Circle()
                            .modifier(CustomCircleModifier(color:color, lineCirclePadding: 2.5, lineWidth: 3))
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
