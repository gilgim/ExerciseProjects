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
    @State var setArray: [SingleSetView] = []
    /// setCount is make of Rountine. In order to this variable is add all sets.
    @State var setCount: Int = 0
    //  ================================ < About ViewModel > ================================
    /// This ViewModel contain set
    @StateObject var createFormVM: CreateRoutineFormViewModel = CreateRoutineFormViewModel()
    //  ================================ < Input Variable > ================================
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                ForEach(setArray, id: \.setNumber) { singleView in
                    singleView
                }
                Button {
                    setArray.append(SingleSetView(setNumber: setCount))
                    setCount += 1
                }label: {
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundColor(.yellow)
                        .overlay {Image(systemName: "plus")}
                }
            }
        }
    }
}
