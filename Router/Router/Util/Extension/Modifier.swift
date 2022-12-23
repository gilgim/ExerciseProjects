//
//  Modifier.swift
//  Router
//
//  Created by KimWooJin on 2022/12/19.
//

import Foundation
import SwiftUI
//  MARK: ButtonTitle
/// -   Korean :    버튼 텍스트를 바꿔주기 위한 모디파이어.
/// -   English :
struct ButtonTitle: ViewModifier {
    @Binding var isSelect: Bool
    func body(content: Content) -> some View {
        content
            .font(Font.system(size: 18, weight: isSelect ? .semibold:.regular, design: .rounded))
    }
}
//  MARK: BackRoundedRecModifier
/// -   Korean :    뒷 배경에 타원을 그려 넣는 모디파이어, 버튼 클릭 시 색상 커스텀하였다.
/// -   English :
struct BackRoundedRecModifier: ViewModifier {
    var cornerValue: CGFloat
    var color: Color
    var selectColor: Color
    var padding: CGFloat
    var isLine: Bool
    /// -   컨텐츠 클릭 시 변경되는 Bool 값
    @Binding var isSelect: Bool
    init(cornerValue: CGFloat, isSelect: Binding<Bool> = .constant(false), color: Color = CustomColor.lightGray.color, selectColor: Color = .mint,
         isLine: Bool = true
         , _ padding: CGFloat = 15) {
        self.cornerValue = cornerValue
        self._isSelect = isSelect
        self.color = color
        self.padding = padding
        self.selectColor = selectColor
        self.isLine = isLine
    }
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerValue)
                .foregroundColor(isSelect ? selectColor.opacity(0.35):color)
            content
                .frame(maxWidth: .infinity)
                .padding(padding)
            if isSelect {
                RoundedRectangle(cornerRadius: cornerValue)
                    .stroke(lineWidth: isLine ? 3:0)
                    .foregroundColor(selectColor)
            }
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
