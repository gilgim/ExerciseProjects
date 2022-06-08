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
 
                TextField("Search", text: $text,onEditingChanged: { bool in
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
            .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
            .foregroundColor(.secondary)
            .background(.gray.opacity(0.2))
            .cornerRadius(10.0)
        }
        .padding(.horizontal)
    }
}
