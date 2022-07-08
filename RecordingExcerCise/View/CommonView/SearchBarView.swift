//
//  SearchBarView.swift
//  RecordingExcerCise
//
//  Created by KimWooJin on 2022/06/08.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @Binding var isTouch : Bool
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black.opacity(0.7))
                TextField("검색", text: $text,onEditingChanged: { bool in
                    if bool {
                        isTouch = false
                    }
                    else{
                        isTouch = true
                    }
                })
                .foregroundColor(.primary)
 
                if !text.isEmpty {
                    Button(action: {
                        self.text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                    }
                } else {
                    EmptyView()
                }
            }
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            .foregroundColor(.secondary)
            .background(Color.Color_15)
            .cornerRadius(10.0)
        }
        .padding(.horizontal)
        .frame(height: 36)
    }
}
