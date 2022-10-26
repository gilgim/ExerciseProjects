//
//  ExerciseFormView.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/10/24.
//

import SwiftUI

struct ExerciseFormView: View {
    var body: some View {
        VStack {
            NavigationLink("Creat Exercise Form") {
                CreateExerciseFormView()
            }
            List {
                VStack {
                    
                }
            }
        }
    }
}

struct ExerciseFormView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseFormView()
    }
}
