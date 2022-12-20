//
//  MainView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/19.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView(selection: .constant(0)) {
            HomeView()
                .tabItem {
                    Image(systemName: "figure.run.square.stack.fill")
                    Text("기록")
                }
            SettingView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("설정")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
