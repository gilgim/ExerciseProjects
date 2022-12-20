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
    func body(content: Content) -> some View {
        RoundedRectangle(cornerRadius: cornerValue)
            .foregroundColor(.lightGray)
            .overlay {
                content
                    .frame(maxWidth: .infinity)
                    .padding(15)
            }
    }
}

struct CustromCircleModifier: ViewModifier {
    @Binding var selectColor: Color?
    @Binding var sfIconName: String?
    func body(content: Content) -> some View {
        content
            .overlay {
                ZStack{
                    Circle()
                        .stroke(lineWidth: 3)
                        .frame(maxWidth: .infinity)
                        //  MARK: 이 부분을 조절해주면 아이콘 을 쉽게 다룰 수  있음.
                        .padding(sfIconName == "" ? 3:5)
                        .overlay {
                            if sfIconName != "" {
                                Image(systemName: sfIconName ?? "plus")
                                    .resizable()
                                    .frame(maxWidth: .infinity)
                                    .scaledToFit()
                                    .padding(30)
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
