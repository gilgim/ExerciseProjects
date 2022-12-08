//
//  ExerciseFormViewModel.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/12/06.
//

import Foundation
class ExerciseFormViewModel: ObservableObject {
    @Published var model = ExerciseFormModel()
    
    /// This variable isn't runtime error but it was used for alerting user.
    @Published var isErrorAlert: Bool = false
    /// This string explain error about isErrorAlert.
    @Published var errorText: String?
    /// This component is used only view.
    @Published var formList: [ExerciseFormStruct] = []
    var temp: Int = 0
    /// If user want to register favorite content, Use this function.
    func registerFavoriteAction(exerciseObject: ExerciseFormStruct, isFavorite: Bool) async {
        var target = exerciseObject
        target.favorite = isFavorite
        model.updateRealmObject(from: exerciseObject, to: target)
    }
    func callingUpExerciseForm() {
        DispatchQueue.global(qos: .userInteractive).async {
            DispatchQueue.main.async {
                self.formList = self.model.readRealmObject()
            }
        }
    }
    ///  List Delete = model data delete
    func deleteExerciseForm(index: IndexSet) {
        temp = index.first!
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.model.deleteRealmObject(target: self.formList[self.temp])
                self.formList.remove(atOffsets: index)
            }
        }
    }
}
