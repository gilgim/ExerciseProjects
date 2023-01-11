//
//  Modifier.swift
//  Router
//
//  Created by KimWooJin on 2022/12/19.
//

import Foundation
import SwiftUI
//  MARK: BackRoundedRecModifier
/// 뷰 뒤 모서리가 둥근 직사각형의 특징을 부여하는 ViewModifier 입니다.
struct BackRoundedRecModifier: ViewModifier {
    //  ===== User Input =====
    @Binding var isSelect: Bool
    
    //  ====== About Views ======
    var cornerValue: CGFloat
    var color: Color
    var selectColor: Color
    var selectLine: Bool
    var padding: CGFloat
    /**
     - parameters:
        -   cornerValue: 꼭짓점 기울기로 대부분 12로 작성했습니다. 하지만 크기마다 커스텀 가능합니다.
        -   isSelect: 유저가 Modifier 된 컨텐츠를 클릭 시 색상 변경을 위한 Binding 값입니다.
        -   color: 초기값을 CustomColor의 밝은 그레이 색상입니다. 커스텀 가능합니다.
        -   selectColor: isSelect 변경 시 변경되는 색상입니다. opacity 값이 0.35으로 설정되어 있습니다.
        -   selectLine: isSelect 변경 시 RoundedRectangle 주변의 굵은 선의 유무입니다. 기본 값은 true 입니다.
        -   padding: Modifier되는 컨텐츠의 사각형 안에서의 padding 값입니다. 기본 값은 15입니다.
     */
    init(cornerValue: CGFloat, isSelect: Binding<Bool> = .constant(false),
         color: Color = CustomColor.lightGray.color, selectColor: Color = .black,
         selectLine: Bool = true, padding: CGFloat = 15) {
        self.cornerValue = cornerValue
        self._isSelect = isSelect
        self.color = color
        self.selectColor = selectColor
        self.selectLine = selectLine
        self.padding = padding
    }
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerValue)
                .foregroundColor(isSelect ? selectColor.opacity(0.35):color)
            content
                .font(Font.system(size: 18, weight: isSelect ? .semibold:.regular, design: .rounded))
                .frame(maxWidth: .infinity)
                .padding(padding)
            if isSelect {
                RoundedRectangle(cornerRadius: cornerValue)
                    .stroke(lineWidth: selectLine ? 3:0)
                    .foregroundColor(selectColor)
            }
        }
    }
}

//  MARK: CustomCircle
/// Icon 이미지를 Circle 과 흰색 라인으로 꾸며주는 Modifier 입니다.
struct CustomCircleModifier: ViewModifier {
    //  ===== User Inputs =====
    @Binding var selectColor: Color?
    @Binding var sfIconName: String?
    
    //  ===== About View =====
    var imagePadding: CGFloat
    var whiteLinePadding: CGFloat
    var lineWidth: CGFloat
    
    /**
     이미지가 변경 될 때 Binding 연결을 하는 Initailize 입니다.
     - parameters:
        -   selectColor: 색상 바인딩 값으로 초기값은 Color의 회색입니다.
        -   sfIconName: 바인딩 되어지는 SF Symbol 이름 값으로 초기값은 nil 입니다. nil 할당 시 Image는 출력되지 않습니다.
        -   imagePadding: 이미지가 원 내에서 가지는 padding 값 입니다. 초기값은 30 입니다.
        -   whiteLinePadding: 원 내부에  흰 선이 원을 기준으로 가지는 padding 값 입니다. 초기값은 5 입니다.
        -   lineWidth: 원 내부에 있는 흰선의 두께 입니다.
     */
    init(selectColor: Binding<Color?> = .constant(.gray), sfIconName: Binding<String?> = .constant(nil),
         imagePadding: CGFloat = 30, whiteLinePadding: CGFloat = 5, lineWidth: CGFloat = 5) {
        self._selectColor = selectColor
        self._sfIconName = sfIconName
        self.imagePadding = imagePadding
        self.whiteLinePadding = whiteLinePadding
        self.lineWidth = lineWidth
    }
    /**
     이미지와 컬러 변경이 필요하지 않아 Binding 연결이 필요하지 않을 때의 initailize 입니다.
     - parameters:
        -   selectColor: 색상  값으로 초기값은 Color의 회색입니다.
        -   sfIconName: SF Symbol 이름 값으로 초기값은 nil 입니다. nil 할당 시 Image는 출력되지 않습니다.
        -   imagePadding: 이미지가 원 내에서 가지는 padding 값 입니다. 초기값은 30 입니다.
        -   whiteLinePadding: 원 내부에  흰 선이 원을 기준으로 가지는 padding 값 입니다. 초기값은 5 입니다.
        -   lineWidth: 원 내부에 있는 흰선의 두께 입니다.
     */
    init(color: Color? = .gray, iconName: String? = nil, _ imagePadding: CGFloat = 30, whiteLinePadding: CGFloat = 5, lineWidth: CGFloat = 5) {
        self._selectColor = .constant(color)
        self._sfIconName = .constant(iconName)
        self.imagePadding = imagePadding
        self.whiteLinePadding = whiteLinePadding
        self.lineWidth = lineWidth
    }
    func body(content: Content) -> some View {
        content
            .overlay {
                ZStack{
                    Circle()
                        .stroke(lineWidth: lineWidth)
                        .frame(maxWidth: .infinity)
                        .padding(whiteLinePadding)
                        .overlay {
                            //  SF symbol 이름이 존재하지 않으면 불필요한 로그가 발생하기 떄문에 Hidden 처리
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
            .foregroundColor(selectColor)
    }
}
//  MARK: - CloseKeyboardModifier
/// Contents를 탭 할 시 키보드를 숨기기 위한 Modifier 입니다.
struct CloseKeyboardModifier: ViewModifier {
    //  ===== User Input =====
    @Binding var isShowKeyboard: Bool
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                self.isShowKeyboard  = false
            }
    }
}
//  MARK: - RoutineSetBottom
/// 루틴 생성 시 부분 루틴 속 세트 요소에 Text를 추가 해주는 Modifier 입니다.
/// 해당 텍스트는 사용자가 설정한 부위 혹은 기존에 설정된 부위가 출력됩니다.
struct RoutineSetBottom: ViewModifier {
    @State var bottomText: String
    func body(content: Content) -> some View {
        VStack {
            content
            Text(bottomText)
                .font(.system(size: 15, weight: .heavy))
        }
    }
}

//  MARK: - ListDragBlock
/// 리스트를 드래그 하기 위한 오른쪽 여백을 생성합니다.
struct ListDragBlock: ViewModifier {
    var color: Color
    var imageColor: Color
    init(color: Color = .gray.opacity(0.5), imageColor: Color = .black) {
        self.color = color
        self.imageColor = imageColor
    }
    func body(content: Content) -> some View {
        content
            .overlay {
                HStack {
                    Spacer()
                    RoundedRectangle(cornerRadius: 12)
                        .trim(from: 0.25, to: 0.75)
                        .rotation(.degrees(180))
                        .foregroundColor(color)
                        .frame(width: 100)
                        .overlay {
                            HStack {
                                Spacer().frame(width: 50)
                                Image(systemName: "text.justify")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(imageColor)
                                    .frame(width: 25)
                            }
                        }
                    
                }
            }
    }
}
