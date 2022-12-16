//
//  SingleSetViewModel.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/12/09.
//

import Foundation
import SwiftUI

class PartialExerciseViewModel: ObservableObject {
    //  ========== Binding Variable ==========
	@Published var model = PartialExerciseModel()
    //  ======================================
    
    /// The function action when dismiss exercise fomr view.
    /// - Parameter array: Adding content from exercise form view
    func dismissExerciseFormView(array: [SingleSetStruct], sequence partialSequence: Int, object selectedObject: ExerciseFormStruct?) -> [SingleSetStruct] {
        var resultArray = array
        var addSingleSetStruct: SingleSetStruct?
        utilPrint(title: "Add SingleSet") {
            if let selectedObject {
                //  selectedObject translate to singleSetStruct.
                addSingleSetStruct = SingleSetStruct(partialSequence: partialSequence, setType: .Exercise, exerciseName: selectedObject.name!)
                //  Image Setting
                if let uiImage = selectedObject.image {
                    addSingleSetStruct?.uiImage = uiImage
                }
                else {
                    addSingleSetStruct?.imageName = bodyPartDefaultSymbol(parts: selectedObject.part!)
                }
                print("Add : \(String(describing: addSingleSetStruct))")
            }
            else {
                addSingleSetStruct = SingleSetStruct(partialSequence: partialSequence, setType: .Rest)
                print("Add : Rest")
            }
            //  Action add.
            if let addSingleSetStruct {
                resultArray.append(addSingleSetStruct)
            }
            else {print("Add Fail")}
        }
        return resultArray
    }
}
