//
//  IconSelectView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/19.
//

import SwiftUI

struct IconSelectView: View {
    @Environment(\.dismiss) var mode
    //  MARK: - User input
    @Binding var selectColor: Color?
    @Binding var sfIconName: String?
    
    /// -   아이콘 및 색상 바인딩
    init(selectColor: Binding<Color?> = .constant(nil), sfIconName: Binding<String?> = .constant(nil)) {
        self._selectColor = selectColor
        self._sfIconName = sfIconName
    }
    var body: some View {
        VStack(spacing: 0) {
            /// **미리보기 아이콘
            Circle()
                .modifier(CustomCircleModifier(selectColor: $selectColor, sfIconName: $sfIconName))
                .frame(width: 150)
                .padding(.vertical, 10)
            /// **색상 선택 뷰
            TitleView(title: "색상")
                .padding(.bottom, 5)
            ColorPickerView(selectColor: $selectColor)
                .padding(.bottom, 10)
            /// **아이콘 선택 뷰
            TitleView(title: "아이콘")
                .padding(.bottom, 5)
            IconPickerView(systemName: $sfIconName)
        }
        .navigationTitle("아이콘 세팅")
    }
}

struct IconSelectView_Previews: PreviewProvider {
    static var previews: some View {
        IconSelectView()
    }
}
