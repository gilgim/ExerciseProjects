//
//  CreateRoutineFormComponent.swift
//  Router
//
//  Created by KimWooJin on 2022/12/26.
//

import SwiftUI

struct CreateRoutineFormComponent: View {
    @State var setArray: [KindOfComponentInRoutine] = []
    @State var isShowExerciseForm: Bool = false
    @State var selectExerciseForm: [ExerciseFormStruct] = []
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(setArray, id: \.id) { componentSet in
                        if let exercise = componentSet.exercise {
                            Button {
                                
                            }label: {
                                Circle()
                                    .modifier(CustomCircleModifier(color: Color(hex: exercise.imageColorName), iconName: exercise.imageName, 15, lineWidth: 3))
                                //  수정이 필요. 파트 부위 선택 및 지정마다
                                    .modifier(RoutineSetBottom(bottomText: "운동"))
                            }
                        }
                        else if componentSet.type == .rest {
                            Button {
                                
                            }label: {
                                Circle()
                                    .modifier(CustomCircleModifier(color: .gray, iconName: "tree", 15, lineWidth: 3))
                                    .modifier(RoutineSetBottom(bottomText: "휴식"))
                            }
                        }
                        if setArray.last == componentSet {
                            Divider()
                                .overlay(Color.gray)
                        }
                        else {
                            Image(systemName: "arrowshape.right.fill")
                                .foregroundColor(.gray)
                        }
                    }
                    Button {
                        self.selectExerciseForm = []
                        self.isShowExerciseForm.toggle()
                    }label: {
                        Circle()
                            .modifier(CustomCircleModifier(color: .blue, iconName: "plus", 15, lineWidth: 3))
                            .modifier(RoutineSetBottom(bottomText: "추가"))
                    }
                    Spacer()
                }
            }
        }
        .modifier(BackRoundedRecModifier(cornerValue: 12))
        .frame(height: 120)
        .sheet(isPresented: $isShowExerciseForm, onDismiss: {
            for selectExer in selectExerciseForm {
                let appendExer = try! KindOfComponentInRoutine(type: .exercise, exercise: selectExer)
                setArray.append(appendExer)
            }
        }) {
            ExerciseFormView(selectedExercises: $selectExerciseForm, isPop: $isShowExerciseForm)
        }
    }
}

struct CreateRoutineFormComponent_Previews: PreviewProvider {
    static var previews: some View {
        CreateRoutineFormComponent()
    }
}
