//
//  ExerciseFormView.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/10/24.
//

import SwiftUI

struct ExerciseFormView: View {
    //  ================================ < View Variable > ================================
    @Environment(\.presentationMode) var mode
    //  ================================ < About ViewModel > ================================
    @StateObject var formVM = ExerciseFormViewModel()
    @StateObject var detailVM = CreateDetailPartViewModel()
    //  ================================ < Input Variable > ================================
    @Binding var exerciseName: String?
    @Binding var isShow: Bool
    init(exerciseName: Binding<String?> = .constant(nil), isShow: Binding<Bool>) {
        self._exerciseName = exerciseName
        self._isShow = isShow
    }
    var body: some View {
        VStack {
            NavigationLink("Creat Exercise Form") {
                CreateExerciseFormView()
            }
            List {
                ForEach(formVM.formList, id: \.name) { exercieseForm in
                    Button {
                        exerciseName = exercieseForm.name
                        if isShow {
                            mode.wrappedValue.dismiss()
                        }
					}label: {
						HStack {
							Image(uiImage: self.formVM.callingUpImage(imageName: "creat_\(exercieseForm.name!)") ?? UIImage())
								.resizable()
								.scaledToFit()
							Text(exercieseForm.name ?? "값이 올바르지 않음")
						}
					}
					.frame(height: 75)
                }
                .onDelete(perform: formVM.deleteExerciseForm)
            }
            .listStyle(InsetListStyle())
        }
        .onAppear {
            self.formVM.callingUpExerciseForm()
        }
    }
}

struct ExerciseFormView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseFormView(isShow: .constant(false))
    }
}
