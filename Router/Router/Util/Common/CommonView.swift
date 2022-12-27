//
//  CommonView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/19.
//

import Foundation
import SwiftUI

/// Placeholder를 추가한 TextEditor 뷰 입니다.
struct CustomTextEditor: View {
    //  ===== User Input =====
    @Binding var text: String
    
    //  ===== About View =====
    var placeholder: String
    var isLink: Bool = false
    
    /**
     -  parameters:
        -   placeholder: 텍스트 값이 없을 시에 표현되는 텍스트 값 입니다.
        -   isLink: Youtube 링크를 추가할 수 있는 버튼의 !hidden 값 입니다.
     */
    init(_ placeholder: String = "" , text: Binding<String>, isLink: Bool = false) {
        self._text = text
        self.placeholder = placeholder
        self.isLink = isLink
    }
    var body: some View {
        TextEditor(text: $text)
            .overlay {
                //  isLink가 true면 링크를 할당 할 수 있는 Button을 뷰에 출력합니다.
                if self.isLink {
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                
                            }label: {
                                Image(systemName: "link.badge.plus")
                                    .padding(10)
                            }
                        }
                        Spacer()
                    }
                }
            }
            //  뒷 배경을 hidden 시키므로써 색상을 통일했습니다.
            .scrollContentBackground(.hidden)
            //  placeholder의 위치를 맞춰주기 위해서 백그라운드에 해당 뷰와 같은 TextEditor를 배치했습니다.
            .background(alignment: .topLeading) {
                TextEditor(text: .constant(text.isEmpty ? placeholder : ""))
                    .foregroundColor(.init(uiColor: .placeholderText))
                    .scrollContentBackground(.hidden)
            }
    }
}
/// 요소들의 타이틀로 쓰이는 뷰입니다. 통일감을 위해서 공통으로 사용됩니다.
struct TitleView: View {
    var title: String
    var body: some View {
        HStack {
            Text(title).padding(.leading, 20)
                .font(Font.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(.init(uiColor: .lightGray))
            Spacer()
        }
    }
}
/// 요소를 검색할 때 사용되는 뷰 입니다. 모든 타입을 검색하기 위해 제네릭 타입으로 작성했습니다.
struct SearchView<T: Hashable>: View {
    /// 사용자가 검색하는 String입니다.
    @Binding var text: String
    @State var array: [T]
    /// 사용자가 클릭하는 버튼입니다
    @Binding var component: T?
    var body: some View {
        VStack {
            //  상단 돋보기의 검색바 입니다.
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("검색", text: $text)
            }
            .modifier(BackRoundedRecModifier(cornerValue: 12, color: .gray.opacity(0.2), padding: 5))
            //  버튼으로 요소를 찾을 수 있는 뷰 입니다.
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(array, id: \.self) { component in
                        Button {
                            //  버튼 클릭 시 현재 클릭되어 있는 값과 같다면 nil를 할당하여 버튼을 해제합니다.
                            if self.component == component {
                                self.component = nil
                            }
                            //  버튼이 클릭되어 있지 않다면 해당 클릭한 버튼의 요소를 할당합니다.
                            else {
                                self.component = component
                            }
                        }label: {
                            if let component = component as? BodyPart {
                                Text(component.rawValue)
                                    .foregroundColor(.black)
                            }
                        }
                        .modifier(
                            BackRoundedRecModifier(cornerValue: 12, isSelect: .constant(self.component == component),
                                                   color: .gray.opacity(0.2),
                                                   selectColor: .black,
                                                   selectLine: false,
                                                   padding: 10))
                    }
                }
            }
        }
        .frame(maxHeight: 80)
    }
}

struct test: PreviewProvider {
    static var previews: some View {
        SearchView(text: .constant(""), array: BodyPart.allCases, component: .constant(.Back))
    }
}
