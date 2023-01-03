//
//  RoutineFormView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/19.
//

import SwiftUI

struct RoutineFormView: View {
    @State var isCreateExercise: Bool = false
    var body: some View {
        VStack {
            
        }
        .navigationTitle("루틴 목록")
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
            CreateRoutineFormView()
        }
    }
}

struct RoutineFormView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineFormView()
    }
}
