//
//  SingleSetModel.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/12/10.
//

import Foundation
///	This struct should contain set type.
struct SingleSetStruct {
	///	The reason this variable is exist is because of using drag & drop.
	var id = UUID()
	///	this variable explain current partical exercise this set is contained.
	var particalExercise: Int
	///	setType express this component in partical Exercise.
	var setType: SetType
	var imageName: String?
	
	//	When setType is exercise.
	///	When setType is exercise, this variable should be exist.
	var exerciseName: String?
	///	When setType is exercise, this variable should be exist.
	var weight: Int?
	///	When setType is exercise, this variable should be exist.
	var count: Int?
	
	//	When setType is rest.
	var restTime: Int?
	
	init(particalExercise: Int, setType: SetType, imageName: String? = nil, exerciseName: String? = nil, weight: Int? = nil, count: Int? = nil, restTime: Int? = nil) {
		self.particalExercise = particalExercise
		self.setType = setType
		if setType == .Rest {
			self.imageName = "cross.vial"
		}
		else {
			self.imageName = imageName
		}
		self.exerciseName = exerciseName
		self.weight = weight
		self.count = count
		self.restTime = restTime
	}
}
extension SingleSetStruct: Equatable {
	static func == (lhs: SingleSetStruct, rhs: SingleSetStruct) -> Bool {
		return lhs.id == rhs.id
	}
}