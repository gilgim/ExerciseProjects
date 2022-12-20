//
//  ColorPickerView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/20.
//

import SwiftUI
struct ColorPickerView: View {
    @Binding var selectColor: Color?
    @State var colorArray: [Color?] = Color.colors
    var colorRows: [GridItem] = .init(repeating: GridItem(.fixed(150/5),spacing: 10), count: 3)
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: colorRows) {
                ForEach($colorArray, id: \.self) { color in
                    Button {
                        self.selectColor = color.wrappedValue
                    }label: {
                        Circle()
                            .modifier(CustromCircleModifier(selectColor: color, sfIconName: .constant("")))
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
