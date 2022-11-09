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
    func affiliatedPartButtonAction(part: BodyPart?)throws -> [String]{
        
        //  $0.name is not "" because it is checked from structChangeObject()
        return try model.readRealmObject().filter({$0.affiliatedPart == part}).map({
            if let name = $0.name{
                return name
            }
            else {
                throw ErrorType.valueIsEmpty
            }
        })
    }
    ///  When user touch plus button, create append new conponent.
    func plusOkButtonAction(part: BodyPart?, append value: String)async {
        //  Check empty value.
        guard let part else {isErrorAlert = true;errorText = "운동부위를 선택해주세요.";return}
        guard value != "" else {isErrorAlert = true;errorText = "값이 비어있습니다.";return}
        
        var object = DetailPartStruct()
        object.affiliatedPart = part
        object.name = value
        self.model.createRealmObject(target: object)
    }
}
