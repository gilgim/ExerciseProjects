//
//  ParticalExerciseModel.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/12/10.
//

import Foundation
struct PartialExerciseModel {
    
}
struct PartialExerciseStruct {
	///	The reason this variable is exist is because of using drag & drop.
	var id: UUID = UUID()
	var setArray: [SingleSetStruct] = []
	var sequence: Int
}
