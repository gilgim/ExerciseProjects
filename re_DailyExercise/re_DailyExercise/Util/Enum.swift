//
//  Enum.swift
//  re_DailyExercise
//
//  Created by KimWooJin on 2022/09/16.
//

import Foundation

public enum AppStatusMessage: String {
    case active = "앱이 활성화 되었습니다."
    case inactive = "앱 상태가 변경됩니다."
    case background = "앱이 백그라운드 상태입니다."
    case unknown = "앱이 알 수 없는 상태가 되었습니다."
}

public enum SearchType {
    case noSearch
    case keyboard
    case button
}
