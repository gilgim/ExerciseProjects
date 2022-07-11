//
//  RoutineView.swift
//  RecordingExcerCise
//
//  Created by KimWooJin on 2022/05/02.
//

import SwiftUI

struct RoutineView: View {
    @State var temp = routine_CtgryViewContent(name: "초급자용", strength: "모름", bodyPart: ["등"])
    var body : some View{
        routine_CtgryViewStyle(content: temp)
    }
}
