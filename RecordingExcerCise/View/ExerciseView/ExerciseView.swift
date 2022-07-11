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
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    let temp : [ex_CtgryViewContent] = [ex_CtgryViewContent(name: "바벨로우", bodyPart: ["등"], detailPart: ["등 상부","중간"]),ex_CtgryViewContent(name: "인클라인 벤치프레스", bodyPart: ["가슴"], detailPart: ["가슴 상부"]),ex_CtgryViewContent(name: "덤벨로우", bodyPart: ["가슴","등"], detailPart: ["상부","중간"])]
    var body: some View {
        exerContentView(text: searchText, isTouch: searchTouch, contents: .constant(temp), type: .constant(.exercise))
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView()
    }
}
