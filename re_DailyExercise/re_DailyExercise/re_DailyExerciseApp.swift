//
//  re_DailyExerciseApp.swift
//  re_DailyExercise
//
//  Created by KimWooJin on 2022/08/25.
//

import SwiftUI

@main

struct re_DailyExerciseApp: App {
    @Environment(\.scenePhase) private var scenePhase
    static var disableScroll: Bool = false
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { sceneStatus in
            switch sceneStatus {
            case .active:
                AppStatusManager.shared.isActive = true
                print(AppStatusMessage.active.rawValue)
            case .background:
                AppStatusManager.shared.isActive = false
                print(AppStatusMessage.background.rawValue)
                break
            case .inactive:
                print(AppStatusMessage.inactive.rawValue)
                break
            @unknown default:
                print(AppStatusMessage.unknown.rawValue)
                break
            }
        }
    }
}
