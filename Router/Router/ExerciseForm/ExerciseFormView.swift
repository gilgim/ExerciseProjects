//
//  ExerciseFormView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/19.
//

import SwiftUI

struct ExerciseFormView: View {
    @State var isCreateExercise: Bool = false
    var body: some View {
        ScrollView(.vertical) {
            Text("목차들")
                .font(Font.system(size: 16, weight: .bold, design: .rounded))
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
