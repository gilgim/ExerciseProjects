//
//  RoutineFormModel.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/12/08.
//

import Foundation
import RealmSwift
import SwiftUI

/// This struct is exercise content in routine.
struct ExerciseInRoutineSet: Equatable {
    /// This type is used to distinguish current exercise in routine set
    var type: SetContentType
    // FIXME: 여기 뷰여서 고쳐야함
    var id: UUID = UUID()
    var image: Image
    var sequence: Int
    /// The reason this variable is obtional is because if type is rest, name should be empty value.
    var name: String?
    var weight: Int?
    var exerciseCount: Int?
    var restTime: Int?
    
    init(type: SetContentType, image: Image, sequence: Int ,name: String? = nil, weight: Int? = nil, exerciseCount: Int? = nil, restTime: Int? = nil) {
        self.type = type
        self.image = image
        self.name = name
        self.sequence = sequence
        switch type {
        case .Exercise:
            self.weight = weight
            self.exerciseCount = exerciseCount
            self.name = name
        case.Rest:
            self.restTime = restTime
        }
    }
    
    static func == (lhs: ExerciseInRoutineSet, rhs: ExerciseInRoutineSet) -> Bool {
        return lhs.id == rhs.id
    }
}

