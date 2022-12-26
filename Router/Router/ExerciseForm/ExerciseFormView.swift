//
//  ExerciseFormView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/19.
//

import SwiftUI

struct ExerciseFormView: View {
    @State var isCreateExercise: Bool = false
    @State var searchText = ""
    @State var userSelectPart: BodyPart?
    @Binding var selectedExercises: [ExerciseFormStruct]
    @Binding var isPop: Bool
    init(selectedExercises: Binding<[ExerciseFormStruct]> = .constant([]), isPop: Binding<Bool> = .constant(false)) {
        self._selectedExercises = selectedExercises
        self._isPop = isPop
    }
    var body: some View {
        NavigationView {
            VStack {
                if isPop {
                    Spacer()
                }
                SearchView(text: $searchText, array: BodyPart.allCases, component: $userSelectPart)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .font(.system(size: 15))
                    .padding(.horizontal, 10)
                List {
                    ForEach(TestDouble.exercise(), id: \.name) { exercise in
                        if searchText == "" || (exercise.name).contains(searchText) {
                            if userSelectPart == nil || exercise.parts.contains(where: {$0 == userSelectPart}) {
                                Button {
                                    if isPop {
                                        if !selectedExercises.contains(exercise) {
                                            selectedExercises.append(exercise)
                                        }
                                        else {
                                            selectedExercises = selectedExercises.filter({$0 != exercise})
                                        }
                                    }
                                }label: {
                                    HStack {
                                        Circle()
                                            .modifier(
                                                CustomCircleModifier(color: .init(hex: exercise.imageColorName),iconName: exercise.imageName, 12, lineWidth: 2)
                                            )
                                        VStack(alignment: .leading) {
                                            HStack {
                                                ForEach(exercise.parts, id: \.self) {Text($0.rawValue)}
                                            }
                                            .fontWeight(.light)
                                            .foregroundColor(.gray)
                                            Text(exercise.name)
                                                .font(.system(size: 25))
                                        }
                                        .padding(.leading, 10)
                                        Spacer()
                                    }
                                    .frame(height: 50)
                                    .modifier(
                                        BackRoundedRecModifier(cornerValue: 10, isSelect: isPop ? .constant(selectedExercises.contains(where: {$0 == exercise})):.constant(false))
                                    )
                                }
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .listRowSeparator(.hidden)
                            }
                        }
                    }
                }
                .listStyle(InsetListStyle())
            }
            .navigationBarHidden(!isPop)
            //  MARK: Sheet 로 호출되었을 때 설정되는 값
            .navigationTitle("선택하기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.isPop.toggle()
                        self.selectedExercises = []
                    }label: {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.isPop.toggle()
                    }label: {
                        Text("\(selectedExercises.count)개 선택완료")
                    }
                }
            }
        }
        //  MARK: 스택으로 쌓였을 때 설정되는 값
        .navigationTitle("운동 목록")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    self.isCreateExercise.toggle()
                }label: {
                    Image(systemName: "plus")
                }
            }
        }
        .navigationDestination(isPresented: $isCreateExercise) {
            CreateExerciseFormView()
        }
    }
}

struct ExerciseFormView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseFormView()
    }
}
