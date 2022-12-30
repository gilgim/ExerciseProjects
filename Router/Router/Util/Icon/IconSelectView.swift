//
//  IconSelectView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/19.
//

import SwiftUI

/// 앱 전반에 걸쳐 사용된 아이콘을 만드는 뷰입니다.
struct IconSelectView: View {
    //  ===== User Input =====
    @Binding var selectColor: CustomColor?
    @Binding var sfIconName: String?
    
    //  ===== About View =====
    @Environment(\.dismiss) var mode
    
    /**
    호출한 뷰와 바인딩 연결을 진행하는 initailize 입니다.
     
     -  parameters:
        - selectColor: 유저가 선택하는 바인딩 컬러 값 입니다.
        - sfIconName: 유저가 선택하는 SF Symbol의 이름 입니다.
     */
    init(selectColor: Binding<CustomColor?> = .constant(nil), sfIconName: Binding<String?> = .constant(nil)) {
        self._selectColor = selectColor
        self._sfIconName = sfIconName
    }
    var body: some View {
        VStack(spacing: 0) {
            //  아이콘을 표현하는 뷰 입니다.
            Circle()
                .modifier(CustomCircleModifier(selectColor: .constant(selectColor?.color), sfIconName: $sfIconName))
                .frame(width: 150)
                .padding(.vertical, 10)
            //  아이콘의 색상을 선택하는 뷰 입니다.
            TitleView(title: "색상")
                .padding(.bottom, 5)
            ColorPickerView(selectColor: $selectColor)
                .padding(.bottom, 10)
            //  아이콘의 문양을 선택하는 뷰 입니다.
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
