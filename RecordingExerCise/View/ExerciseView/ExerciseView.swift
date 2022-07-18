//
//  Exercise.swift
//  RecordingExcerCise
//
//  Created by KimWooJin on 2022/05/02.
//

import SwiftUI
import RealmSwift

struct ExerciseView: View {
    @State var searchText = ""
    @State var searchTouch = false
    @State var objectCount : Int = 0
    @State var exerciseData : [ExerciseModel] = []
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    let temp : [ExerciseModel] = [ExerciseModel(name: "바벨로우", bodyPart: ["등"], detailPart: ["등 상부","중간"]),ExerciseModel(name: "인클라인 벤치프레스", bodyPart: ["가슴"], detailPart: ["가슴 상부"]),ExerciseModel(name: "덤벨로우", bodyPart: ["가슴","등"], detailPart: ["상부","중간"])]
    var body: some View {
        CommonContentView(text: searchText, isTouch: searchTouch, contents: .constant(exerciseData), type: .constant(.exercise))
            .onAppear{
                print(Realm.Configuration.defaultConfiguration.fileURL)
                let realm = try? Realm()
                if let realm = realm{
                    for realmData in realm.objects(ExerciseObject.self).reversed() {
                        exerciseData.append(ExerciseModel(managedObject: realmData))
                    }
                }
            }
    }
}
