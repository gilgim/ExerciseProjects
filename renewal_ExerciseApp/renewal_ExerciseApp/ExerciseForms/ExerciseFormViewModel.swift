//
//  ExerciseFormViewModel.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/12/06.
//

import Foundation
import UIKit

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
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                var target = exerciseObject
                target.favorite = isFavorite
                self.model.updateRealmObject(from: exerciseObject, to: target)
            }
        }
    }
    //  FIXME: 결합도가 너무 높다. 
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
