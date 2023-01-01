//
//  RouterApp.swift
//  Router
//
//  Created by KimWooJin on 2022/12/18.
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
//				if !UserDefaults.standard.bool(forKey: "launchedBefore") {
//					//	첫 실행 시 배열을 미리 생성하기 위한 구문입니다.
//					//	모델을 여기서 호출해도 되는지는 구조적으로 옳은지는 모르겠지만 기능적구현을 위해서 호출했습니다.
//					let model = DetailPartFormModel()
//					for part in BodyPart.allCases {
//						do {
//							try model.saveObject(value: .init(affiliatedPart: part, name: []))
//						}
//						catch {
//							CommonFunction.componentDetailprint()
//							print(error)
//						}
//					}
//					print("Cearte detail parts empty array.")
//					//	첫 실행을 감지하기 위한 값 세팅 구문입니다.
//					UserDefaults.standard.set(true, forKey: "launchedBefore")
//				}
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
