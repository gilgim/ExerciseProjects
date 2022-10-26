//
//  CreateExerciseFormView.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/10/24.
//

import SwiftUI

struct CreateExerciseFormView: View {
    //  ================================ < About View Variable > ================================
    var bodyArray: [BodyPart] = [.Chest, .Back, .lowerBody , .Arms, .Abs]
    //  ================================ < About ViewModel > ================================
    @StateObject var viewModel = CreateExerciseViewModel()
    //  ================================ < Input Variable > ================================
    @State var nameText: String = ""
    @State var explainText: String = ""
    @State var linkText: String = ""
    
    var body: some View {
        VStack {
            //  MARK:  -Name TextField
            TextField("Exercise name", text: $nameText) { isEdit in
                print(isEdit)
            }
            //  MARK:  -Explain TextField
            TextField("Exercise explain", text: $explainText) { isEdit in
                print(isEdit)
            }
            //  MARK:  -Link TextField
            TextField("Exercise link", text: $linkText) { isEdit in
                print(isEdit)
            }
            //  MARK:  -Select body part
            HStack {
                ForEach(bodyArray, id: \.rawValue) { part in
                    Button(part.rawValue) {
                        
                    }
                }
            }
            //  MARK:  -Select detail body part
            ScrollView(.horizontal) {
                HStack {
                    ForEach(bodyArray, id: \.rawValue) { part in
                        Button(part.rawValue) {
                            
                        }
                    }
                }
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct CreateExerciseFormView_Previews: PreviewProvider {
    static var previews: some View {
        CreateExerciseFormView()
    }
}
