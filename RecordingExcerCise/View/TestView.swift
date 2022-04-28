//
//  TestView.swift
//  RecordingExcerCise
//
//  Created by KimWooJin on 2022/03/31.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        NavigationView{
            GeometryReader{ geo in
                ScrollView{
                    ZStack{
                        Color.red
                    }
                    .frame(width: 300, height: 600)
                }
                .padding(.bottom,34)
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
