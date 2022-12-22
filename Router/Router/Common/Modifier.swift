//
//  Modifier.swift
//  Router
//
//  Created by KimWooJin on 2022/12/19.
//

import Foundation
import SwiftUI

/// 뒷 배경에 둥근 사각형이 존재하는 뷰 빌더
struct BackRoundedRecModifier: ViewModifier {
    @State var cornerValue: CGFloat
    @Binding var isSelect: Bool
    init(cornerValue: CGFloat, isSelect: Binding<Bool> = .constant(false)) {
        self.cornerValue = cornerValue
        self._isSelect = isSelect
    }
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerValue)
                .foregroundColor(isSelect ? .lightSeaGreen:.lightGray)
            content
                .frame(maxWidth: .infinity)
                .padding(15)
        }
    }
}
//  MARK: CustomCircle
/// -   Korean :    아이콘을 꾸며주는 Circle을 쉽게 적용하기 위한 Modifier
/// -   English :
struct CustomCircleModifier: ViewModifier {
    //  MARK: - User Input
    @Binding var selectColor: Color?
    @Binding var sfIconName: String?
    //  MARK: - About View
    var imagePadding: CGFloat
    var lineCirclePadding: CGFloat
    var lineWidth: CGFloat
    /// -   유저가 값을 선택해야하는 상황에서의 초기화 함수
    init(selectColor: Binding<Color?> = .constant(nil), sfIconName: Binding<String?> = .constant(nil),
         imagePadding: CGFloat = 30, lineCirclePadding: CGFloat = 5, lineWidth: CGFloat = 5) {
        self._selectColor = selectColor
        self._sfIconName = sfIconName
        self.imagePadding = imagePadding
        self.lineCirclePadding = lineCirclePadding
        self.lineWidth = lineWidth
    }
    /// -   개발자가 유저 선택을 위해 뷰를 구헌하는 상황에서의 초기화 함수
    init(color: Color? = nil, iconName: String? = nil, _ imagePadding: CGFloat = 30, lineCirclePadding: CGFloat = 5, lineWidth: CGFloat = 5) {
        self._selectColor = .constant(color)
        self._sfIconName = .constant(iconName)
        self.imagePadding = imagePadding
        self.lineCirclePadding = lineCirclePadding
        self.lineWidth = lineWidth
    }
    func body(content: Content) -> some View {
        content
            .overlay {
                ZStack{
                    //  -   원의 줄무늬를 표현한다.
                    Circle()
                        .stroke(lineWidth: lineWidth)
                        .frame(maxWidth: .infinity)
                        .padding(lineCirclePadding)
                        .overlay {
                            //  -   빈 값일 경우 image를 출력하지 않는다.
                            if let sfIconName, sfIconName != "" {
                                Image(systemName: sfIconName)
                                    .resizable()
                                    .frame(maxWidth: .infinity)
                                    .scaledToFit()
                                    .padding(imagePadding)
                            }
                        }
                }
                .foregroundColor(.white)
            }
            .foregroundColor(selectColor ?? .gray)
    }
}

struct CloseKeyboardModifier: ViewModifier {
    @Binding var isShowKeyboard: Bool
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                self.isShowKeyboard  = false
            }
    }
}
