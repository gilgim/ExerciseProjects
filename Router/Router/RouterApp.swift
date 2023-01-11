//
//  RouterApp.swift
//  Router
//
//  Created by KimWooJin on 2023/01/03.
//

import SwiftUI

@main
struct RouterApp: App {
    //  앱이 실행될 때 운동리스트를 불러옵니다.
    static var exerciseList: [ExerciseFormStruct]? = {
        return try? ExerciseFormModel().readObjects()
    }()
    @Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .onChange(of: scenePhase) { sceneStatus in
            CommonFunction.printTitle(title: "App Status")
            print("Status Value : \(sceneStatus)")
            switch sceneStatus {
            case .active:
                break
            case .background:
                break
            case .inactive:
                break
            @unknown default:
                break
            }
        }
    }
}
