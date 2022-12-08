//
//  CreateExerciseViewModel.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/10/24.
//

import Foundation
import _PhotosUI_SwiftUI

class CreateExerciseViewModel: ObservableObject {
    @Published var model = ExerciseFormModel()
    
    /// This variable isn't runtime error but it was used for alerting user.
    @Published var isErrorAlert: Bool = false
    /// This string explain error about isErrorAlert.
    @Published var errorText: String?
    @Published var imageData: Data?
    @Published var isCreate: Bool = false
    
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
    
    /// This function create exercise form, but is called alert error, if exercise is contained duplicated components.
    func createButtonAction(exerciseObject: ExerciseFormStruct)  {
        guard let name = exerciseObject.name, name != "" else {errorText = "운동 이름을 입력해주세요."; isErrorAlert = true;return}
        guard let key = exerciseObject.keyValue() else {errorText = "운동 이름이 옳바르지 않습니다. 변경해주세요."; isErrorAlert = true;return}
        guard let part = exerciseObject.part, part.count > 0 else {errorText = "운동 부위를 선택해주세요."; isErrorAlert = true;return}
        guard let equipment = exerciseObject.equipment, equipment.count > 0 else {errorText = "장비를 선택해주세요."; isErrorAlert = true;return}
        guard !model.readRealmObject().contains(where:{$0.name == exerciseObject.name}) else {errorText = "이미 존재하는 운동명입니다."; isErrorAlert = true;return}
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.model.createRealmObject(target: exerciseObject)
                self.model.saveImageToDocumentDirectory(imageName: key, imageData: self.imageData)
                self.isCreate = true
            }
        }
    }
}
