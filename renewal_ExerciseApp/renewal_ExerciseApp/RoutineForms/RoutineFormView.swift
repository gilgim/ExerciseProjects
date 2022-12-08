//
//  RoutineFormView.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/10/24.
//

import SwiftUI

struct RoutineFormView: View {
    @State var isOpen = false
    @State var UIimage: UIImage?
    var body: some View {
        VStack {
            NavigationLink("Create RoutineForm") {
                CreateRoutineFormView()
            }
        }
    }
}

struct RoutineFormView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineFormView()
    }
}
