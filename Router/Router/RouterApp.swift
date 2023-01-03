//
//  RouterApp.swift
//  Router
//
//  Created by KimWooJin on 2023/01/03.
//

import SwiftUI

@main
struct RouterApp: App {
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
