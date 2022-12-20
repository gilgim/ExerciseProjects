//
//  IconSelectView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/19.
//

import SwiftUI

struct IconSelectView: View {
    //  MARK: - @Binding 사용자 커스텀 색상 및 아이콘
    @Binding var selectColor: Color?
    @Binding var sfIconName: String?
    //  MARK: - Grid 뷰 작성을 위한 행 값
    var data: [String] = Array(1...30).map({"목록 \($0)"})
    
    init(selectColor: Binding<Color?> = .constant(nil), sfIconName: Binding<String?> = .constant(nil)) {
        self._selectColor = selectColor
        self._sfIconName = sfIconName
    }
    var body: some View {
        VStack(spacing: 0) {
            //  미리보기 아이콘
            Circle()
                .modifier(CustromCircleModifier(selectColor: $selectColor, sfIconName: $sfIconName))
                .frame(width: 150)
                .padding(.vertical, 10)
            TitleView(title: "색상")
            .padding(.bottom, 5)
            //  색상 선택 뷰
            ColorPickerView(selectColor: $selectColor)
                .padding(.bottom, 10)
            TitleView(title: "아이콘")
            .padding(.bottom, 5)
            //   아이콘 선택 뷰
            IconPickerView(systemName: $sfIconName)
            Spacer()
        }
        .navigationTitle("아이콘 세팅")
    }
}

struct IconSelectView_Previews: PreviewProvider {
    static var previews: some View {
        IconSelectView()
    }
}
