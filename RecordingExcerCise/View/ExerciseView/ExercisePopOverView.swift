//
//  ExercisePopOverView.swift
//  RecordingExcerCise
//
//  Created by KimWooJin on 2022/06/14.
//

import SwiftUI
import RealmSwift
/**
    운동 정보 클릭 시 팝 오버 되는 뷰
 */
struct ExercisePopOverView: View {
    @Binding var count : Int
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
        NavigationView{
            let realm = try! Realm()
            let result = realm.objects(Exercise.self)
            ZStack{
                Color.Color_04.edgesIgnoringSafeArea(.bottom)
                ScrollView{
                    VStack{
                        HStack{
                            Text("\(result[count].name!)")
                                .padding()
                            Spacer()
                        }
                        ZStack{
                            RoundedRectangle(cornerRadius: 13)
                                .foregroundColor(.white)
                            VStack{
                                Text(result[count].explainExcercise!)
                                    
                                Spacer()
                            }
                        }
                        .padding(10)
                        Spacer()
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button{
                        }label: {
                            Text("편집")
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button{
                            self.mode.wrappedValue.dismiss()
                        }label: {
                            Image(systemName: "xmark")
                        }
                    }
                }
            }
        }
    }
}
