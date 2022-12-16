//
//  RoutineFormModel.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/12/16.
//

import Foundation
import UIKit

struct RoutineFromStruct {
    
    /// This variable can be existed, if there is not uiimage.
    var sfSymbolName: String?
    
    /// This variable don't save in realm.
    /// This variable can be existed, if user regised uiimage name.
    var image: UIImage?
    
    var name: String
    var partialExArray: [PartialExerciseStruct] = []
    var favorite: Bool
}
