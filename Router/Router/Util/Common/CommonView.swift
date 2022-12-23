//
//  CommonView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/19.
//

import Foundation
import SwiftUI

struct CustomTextEditor: View {
    @Binding var text: String
    @State var placeholder: String
    var isLink: Bool = false
    init(_ placeholder: String = "" , text: Binding<String>, isLink: Bool = false) {
        self._text = text
        self.placeholder = placeholder
        self.isLink = isLink
    }
    var body: some View {
        TextEditor(text: $text)
            .overlay {
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
            .scrollContentBackground(.hidden)
            .background(alignment: .topLeading) {
                TextEditor(text: .constant(text.isEmpty ? placeholder : ""))
                    .foregroundColor(.init(uiColor: .placeholderText))
                    .scrollContentBackground(.hidden)
            }
    }
}

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
struct RoundedComponentView: View {
    @State var title: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(CustomColor.lightGray.color)
            Text(title)
                .font(Font.system(size: 18, weight: .semibold, design: .rounded))
                .padding(10)
        }
    }
}
struct SearchView<T: Hashable>: View {
    @Binding var text: String
    @State var array: [T]
    @Binding var component: T?
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("검색", text: $text)
            }
            .modifier(BackRoundedRecModifier(cornerValue: 12, color: .gray.opacity(0.2), 5))
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(array, id: \.self) { component in
                        Button {
                            if self.component == component {
                                self.component = nil
                            }
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
                                                   isLine: false,
                                                   10))
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
