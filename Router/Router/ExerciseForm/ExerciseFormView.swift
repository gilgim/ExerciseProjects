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
    @Binding var isPop: Bool
    init(isPop: Binding<Bool> = .constant(false)) {
        self._isPop = isPop
    }
    var body: some View {
        VStack {
            if !isPop {
                SearchView(text: $searchText, array: BodyPart.allCases, component: $userSelectPart)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .font(.system(size: 15))
                    .padding(.horizontal, 10)
            }
            List {
                ForEach(TestDouble.exercise(), id: \.name) { exercise in
                    Button {
                    
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
                        .modifier(BackRoundedRecModifier(cornerValue: 10))
                    }
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(InsetListStyle())
        }
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
