//
//  CreateRoutineView.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/12/08.
//

import Foundation
import SwiftUI

struct CreateRoutineFormView: View {
    //  ================================ < About View Variable > ================================
    /// setArray component is Single Set that can be contain only exercise and rest.
    @State var partialExArray: [PartialExerciseStruct] = []
    /// setCount is make of Rountine. In order to this variable is add all sets.
    @State var setCount: Int = 0
    //  ================================ < About ViewModel > ================================
    /// This ViewModel contain set
//    @StateObject var createFormVM: CreateRoutineFormViewModel = CreateRoutineFormViewModel()
    //  ================================ < Input Variable > ================================
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(partialExArray, id: \.id) { partialExercise in
					PartialExerciseView(partialExNumber: partialExercise.sequence)
                }
                Button {
					let temp = PartialExerciseStruct(sequence: setCount)
					partialExArray.append(temp)
                    setCount += 1
                }label: {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.yellow)
						.frame(height: 30)
                        .overlay {Image(systemName: "plus")}
                }
            }
        }
    }
}
