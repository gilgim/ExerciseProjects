//
//  MainView.swift
//  re_DailyExercise
//
//  Created by KimWooJin on 2022/08/25.
//

import SwiftUI

struct MainView: View {
    let bgroundColors: [Color] = [.red,.white,.blue]
    @StateObject static var vm: MainViewModel = .init()
    var body: some View {
        SafeVStack(bgroundColors) {
            TabView(selection: .constant(1)) {
                ItemZstack(tag: 0, tagImage: "calendar", tagText: "기록보기") {
                    
                }
                ItemZstack(tag: 1, tagImage: "hand.thumbsup.fill", tagText: "운동하기") {
                    ChoiceExercise()
                }
                ItemZstack(tag: 2, tagImage: "gearshape.fill", tagText: "설정") {
                    
                }
            }
        }
    }
}
struct ChoiceExercise: View {
    var body: some View {
        SafeVStack {
            NavigationLink {
                RoutineView()
            }label: {
                RoundedRecView(.mint,cornerValue: 20) {
                    Text("루틴으로 하기").foregroundColor(.black)
                }
                .padding()
            }
            NavigationLink {
                ExerciseView()
            }label: {
                RoundedRecView(.green,cornerValue: 20) {
                    Text("개별 운동으로 하기").foregroundColor(.black)
                        .onAppear {
                            try? Util.realmURL()
                        }
                }
                .padding()
            }
        }
        .navigationTitle("방식 선택")
    }
}
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
