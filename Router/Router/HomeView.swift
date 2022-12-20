//
//  HomeView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/19.
//

import SwiftUI

struct HomeView: View {
    @State var path: [ViewType] = []
    @State var isCreateContents: Bool = false
    @State var isShowRoutine: Bool = false
    @State var isShowExercise: Bool = false
    var body: some View {
        NavigationStack(path: $path) {
            //  FIXME: 운동을 없는거 디폴트로 한거라서 고쳐야함
            VStack {
                Text("운동 기록이 아직 존재하지 않습니다!")
                    .font(Font.system(size: 16, weight: .bold, design: .rounded))
            }
            .navigationTitle("요약")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.isCreateContents.toggle()
                    }label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationDestination(for: ViewType.self) {
                switch $0 {
                case .ExerciseFormView:
                    ExerciseFormView()
                case .RoutineFormView:
                    RoutineFormView()
                }
            }
        }
        .confirmationDialog("컨텐츠 생성", isPresented: $isCreateContents) {
            Button("루틴") {path.append(.RoutineFormView)}
            Button("운동") {path.append(.ExerciseFormView)}
        }message: {
            Text("생성하실 컨텐츠를 선택해주세요.")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
