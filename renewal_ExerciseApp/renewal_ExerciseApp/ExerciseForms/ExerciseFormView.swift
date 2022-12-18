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
    @Binding var exerciseForm: ExerciseFormStruct?
    @Binding var isShow: Bool
    @Binding var clickEvent: Bool
    init(exerciseForm: Binding<ExerciseFormStruct?> = .constant(nil), isShow: Binding<Bool> = .constant(false), clickEvent: Binding<Bool> = .constant(false)) {
        self._exerciseForm = exerciseForm
        self._isShow = isShow
        self._clickEvent = clickEvent
    }
    var body: some View {
        VStack {
            if isShow {
                Button("Add Rest") {
                    self.clickEvent = true
                    self.exerciseForm = nil
                    self.mode.wrappedValue.dismiss()
                }
            }
            else {
                NavigationLink("Creat Exercise Form") {
                    CreateExerciseFormView()
                }
            }
            List {
                ForEach(formVM.formList, id: \.name) { exerciseForm in
                    Button {
                        self.clickEvent = true
                        self.exerciseForm = exerciseForm
                        if isShow {
                            mode.wrappedValue.dismiss()
                        }
					}label: {
						HStack {
                            if let image = exerciseForm.image {
                                Image(uiImage: image)w
                                    .resizable()
                                    .scaledToFit()
                            }
                            else {
                                Image(systemName: exerciseForm.sfSymbolName ?? "dumbbell.fill")
                                    .resizable()
                                    .scaledToFit()
                            }
                            Text(exerciseForm.name ?? "값이 올바르지 않음")
						}
					}
					.frame(height: 75)
                }
                .onDelete(perform: formVM.deleteExerciseForm)
            }
            .onAppear {
                self.formVM.callingUpExerciseForm()
            }
            .listStyle(InsetListStyle())
        }
    }
}

struct ExerciseFormView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseFormView(isShow: .constant(false))
    }
}
