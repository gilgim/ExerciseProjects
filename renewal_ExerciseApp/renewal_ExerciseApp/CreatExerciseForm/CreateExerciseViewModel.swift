//
//  CreateExerciseViewModel.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/10/24.
//

import Foundation

class CreateExerciseViewModel: ObservableObject {
    @Published var model = ExerciseFormModel()
    
    /// This variable isn't runtime error but it was used for alerting user.
    @Published var isErrorAlert: Bool = false
    /// This string explain error about isErrorAlert.
    @Published var errorText: String?
    
    /// If user want to register favorite content, Use this function.
    func registerFavoriteAction(exerciseObject: ExerciseFormStruct, isFavorite: Bool) async {
        var target = exerciseObject
        target.favorite = isFavorite
        await model.updateRealmObject(from: exerciseObject, to: target)
    }
    
    /// This function create exercise form, but is called alert error, if exercise is contained duplicated components.
    func createButtonAction(exerciseObject: ExerciseFormStruct) async {
        guard !model.readRealmObject().contains(where:{$0.name == exerciseObject.name}) else {errorText = "이미 존재하는 운동명입니다."; isErrorAlert = true;return}
        await model.createRealmObject(target: exerciseObject)
    }
}
