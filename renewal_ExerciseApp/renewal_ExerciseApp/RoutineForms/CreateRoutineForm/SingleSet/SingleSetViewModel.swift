//
//  SingleSetViewModel.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/12/09.
//

import Foundation

class SingleSetViewModel: ObservableObject {
    /// This array is contain exercise and rest
    @Published var exerciseAndRestArray: [ExerciseInRoutineSet] = []
    
    /// This function
    func addComponentButtonAction() {
        
    }
    func dummyData() {
        let value1 = ExerciseInRoutineSet(type: .Exercise, image: .init(systemName: "figure.run"), sequence: 0, name: "value1")
        let rest1 = ExerciseInRoutineSet(type: .Rest, image: .init(systemName: "figure.walk"), sequence: 1)
        let value2 = ExerciseInRoutineSet(type: .Exercise, image: .init(systemName: "figure.walk.motion"), sequence: 2, name: "value2")
        let rest2 = ExerciseInRoutineSet(type: .Rest, image: .init(systemName: "figure.wave"), sequence: 3)
        let value3 = ExerciseInRoutineSet(type: .Exercise, image: .init(systemName: "figure.fall"), sequence: 4, name: "value3")
        self.exerciseAndRestArray = [value1, rest1, value2, rest2, value3]
    }
}
