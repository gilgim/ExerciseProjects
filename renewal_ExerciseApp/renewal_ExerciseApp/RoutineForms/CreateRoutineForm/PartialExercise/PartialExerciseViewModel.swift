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
    //  FIXME: 결합도가 너무 높음 : Array, image
    func changeSelectComponentAction(setArray: inout [SingleSetStruct], particalSequence: Int, selectedObject: ExerciseFormStruct?) {
        var transform: SingleSetStruct?
        if let selectedObject = selectedObject {
            transform = SingleSetStruct(particalSequence: particalSequence, setType: .Exercise, exerciseName: selectedObject.name!)
            if let uiImage = selectedObject.image {
                transform?.uiImage = uiImage
            }
            else {
                transform?.imageName = bodyPartDefaultSymbol(parts: selectedObject.part!)
            }
            setArray.append(transform!)
            print(" add : \(transform!)")
        }
        else {
            transform = SingleSetStruct(particalSequence: particalSequence, setType: .Rest)
            print("add : Rest")
            setArray.append(transform!)
        }
    }
}
