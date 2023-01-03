//
//  MainView.swift
//  Router
//
//  Created by KimWooJin on 2023/01/03.
//

import Foundation
import SwiftUI
import RealmSwift

struct MainView: View {
    init() {
        UITabBar.appearance().backgroundColor = .white
    }
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
        .onAppear() {
            //  앱 실행 시 Realm 파일의 위치를 출력합니다.
            CommonFunction.printTitle(title: "URL", isDetail: false)
            if let realmUrl = Realm.Configuration.defaultConfiguration.fileURL {
                print("RealmFileURL : \(realmUrl)")
            }
            else {
                print("Can't find realm url.")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
