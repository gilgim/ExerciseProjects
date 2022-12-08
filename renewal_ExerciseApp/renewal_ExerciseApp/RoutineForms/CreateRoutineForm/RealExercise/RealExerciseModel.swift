//
//  RealExerciseModel.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/12/08.
//

import Foundation
import RealmSwift

struct RealExerciseStruct {
    /// This name is contained Real Exercise.
    var name: String?
    /// This variable is sign up one exercise by user
    var setSequence: [SetType]?
    var weightAndNumber: [Int: [Double:Int]]?
    var spendTime: Int?
}
