//
//  SettingView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/19.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        VStack {
            Text("설정")
                .font(Font.system(size: 16, weight: .bold, design: .rounded))
        }
        .navigationTitle("설정")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
