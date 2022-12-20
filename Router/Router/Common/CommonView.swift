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
