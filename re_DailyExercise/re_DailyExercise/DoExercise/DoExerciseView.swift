//
//  DoExerciseView.swift
//  re_DailyExercise
//
//  Created by KimWooJin on 2022/09/16.
//

import Foundation
import SwiftUI

struct DoExerciseView: View {
    @Environment(\.presentationMode) var mode
    @StateObject var vm = DoExerciseViewModel()
    @Binding var choiceRoutine: RoutineModel
    @State var isBackAlert: Bool = false
    @State var isStop = false
    @State var timer: Timer?
    var body: some View {
        SafeVStack {
            HStack {
                Text(choiceRoutine.name+" : "+vm.transTime()).padding()
                Spacer()
            }
            Button {
                timer = Timer.scheduledTimer(withTimeInterval: 1.0,repeats: true) {_ in
                            vm.totalTime += 1
                        }
            }label: {
                RoundedRecView(.blue, cornerValue: 13) {
                    Text("운동 시작").foregroundColor(.white)
                }
            }
            Spacer()
        }
        .navigationTitle("")
        .onAppear {
            vm.choiceRoutine = choiceRoutine
        }
        .onDisappear {
            timer?.invalidate()
        }
        .alert("운동 종료",isPresented: $isBackAlert) {
            Button("취소",role: .cancel){}
            Button("확인",role: .destructive){mode.wrappedValue.dismiss()}
        }message: {
            Text("정말 운동을 종료하시겠습니까?")
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement:.navigationBarLeading) {
                Button {
                    isBackAlert.toggle()
                }label: {
                    Text("뒤로가기")
                }
            }
            ToolbarItem(placement:.navigationBarTrailing) {
                if isStop {
                    Button {
                        timer = Timer.scheduledTimer(withTimeInterval: 1.0,repeats: true) {_ in
                                    vm.totalTime += 1
                                }
                        isStop.toggle()
                    }label: {
                        Text("다시 시작")
                    }
                } else{
                    Button {
                        timer?.invalidate()
                        isStop.toggle()
                    }label: {
                        Text("멈춤")
                            .foregroundColor(.red)
                    }
                }
            }
        }
    }
}
