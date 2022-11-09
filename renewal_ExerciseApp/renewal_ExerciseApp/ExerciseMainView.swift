//
//  ExerciseMainView.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/10/24.
//

import SwiftUI

struct ExerciseMainView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("Go Exercise Form") {
                    ExerciseFormView()
                }
                NavigationLink("Creat Routine Form") {
                    RoutineFormView()
                }
                NavigationLink("Creat Exercise Real") {
                    
                }
                NavigationLink("Creat Routine Real") {
                    
                }

            }
        }
    }
}

struct ExerciseMainView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseMainView()
    }
}
