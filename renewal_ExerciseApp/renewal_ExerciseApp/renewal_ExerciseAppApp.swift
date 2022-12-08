//
//  renewal_ExerciseAppApp.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/10/24.
//

import SwiftUI
import Foundation
import PhotosUI
@main
struct renewal_ExerciseAppApp: App {
    @Environment(\.scenePhase) private var scenePhase
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { sceneStatus in
            utilPrint(title: "App Status") {
                print("status : \(sceneStatus)")
                switch sceneStatus {
                case .active:
//                    PHPhotoLibrary.requestAuthorization { status in
//                        print("photo Library state : \(status)")
//                    }
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
}

