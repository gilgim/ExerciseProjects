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
    
    /// When user touch affiliated part button, read data from Realm
    func affiliatedPartButtonAction(part: BodyPart)throws -> [String]{
        
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
    func plusButtonAction(array: inout [String], to value: String) {
        array.append(value)
    }
    /// When user touch create button, save data in Realm.
    func creatButtonAction() {
        
    }
}
