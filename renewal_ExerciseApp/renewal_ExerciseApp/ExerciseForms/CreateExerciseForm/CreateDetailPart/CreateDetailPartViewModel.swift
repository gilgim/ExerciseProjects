//
//  CreateDetailPartViewModel.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/10/24.
//

import Foundation
import RealmSwift

class CreateDetailPartViewModel: ObservableObject {
    @Published var model: DetailPartModel = DetailPartModel()
    
    /// This variable isn't runtime error but it was used for alerting user.
    @Published var isErrorAlert: Bool = false
    
    /// This string explain error about isErrorAlert.
    @Published var errorText: String?
    
    /// When user touch affiliated part button, read data from Realm.
    func affiliatedPartButtonAction(part: BodyPart?) throws -> [DetailPartStruct]{
        //  $0.name is not "" because it is checked from structChangeObject()
        return try model.readRealmObject().filter({$0.affiliatedPart == part}).map({
            if $0.name != nil {
                return $0
            }
            else {
                throw ErrorType.valueIsEmpty
            }
        })
    }
    ///  When user touch plus button, create append new conponent.
    func plusOkButtonAction(part: BodyPart?, append value: String) {
        //  Check empty value.
        guard let part else {self.isErrorAlert = true;self.errorText = "운동부위를 선택해주세요.";return}
        guard value != "" else {self.isErrorAlert = true;self.errorText = "값이 비어있습니다.";return}
        var object = DetailPartStruct()
        object.affiliatedPart = part
        object.name = value
        self.model.createRealmObject(target: object)
        if ErrorControl.errorMessage != .none {
            DispatchQueue.main.async {
                self.isErrorAlert = true
                self.errorText = ErrorControl.errorMessage.rawValue
            }
        }
    }
}
