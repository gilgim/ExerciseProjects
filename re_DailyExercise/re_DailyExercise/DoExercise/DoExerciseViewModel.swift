//
//  DoExerciseViewModel.swift
//  re_DailyExercise
//
//  Created by KimWooJin on 2022/09/16.
//

import Foundation
import SwiftUI

class DoExerciseViewModel: ObservableObject {
    @Published var totalTime: Int = 0
    @Published var choiceRoutine: RoutineModel = RoutineModel()
}
//  MARK: -Functions
extension DoExerciseViewModel {
    func transTime() -> String {
        let second: Int = totalTime % 60
        let minute: Int = totalTime / 60
        let hour: Int = totalTime / 60 / 60
        var secondString: String {
            get {
                if second < 10 {
                    return "0\(second)"
                }
                else {
                    return "\(second)"
                }
            }
        }
        var minuteString: String {
            get {
                if minute < 10 {
                    return "0\(minute)"
                }
                else {
                    return "\(minute)"
                }
            }
        }
        var hourString: String {
            get {
                if hour < 10 {
                    return "0\(hour)"
                }
                else {
                    return "\(hour)"
                }
            }
        }
        return hourString + " : " + minuteString + " : " + secondString
    }
}
