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
    
    //  ViewModels
    @StateObject var mainVm: MainViewModel
    @StateObject var vm = DoExerciseViewModel()
    
    //  Various
    @Binding var choiceRoutine: RoutineModel
    @State var isFirstStart: Bool = false
    @State var isFinish: Bool = false
    @State var isBackAlert: Bool = false
    @State var isStop = false
    
    var body: some View {
        SafeVStack {
            //  루틴명 및 시간
            HStack {
                Text("운동시간 : "+vm.transTime()).padding()
                Spacer()
            }
            ScrollView {
                ForEach($choiceRoutine.choiceExercises, id: \.name) { $exercise in
                    DoExerciseIndex(exercise: $exercise)
                }
            }
            //  운동시작 버튼
            Button {
                if !isFirstStart {
                    mainVm.startTime {
                        vm.totalTime += 1
                        print("gogo")
                    }
                }
                withAnimation {
                    isFirstStart = true
                }
            }label: {
                RoundedRecView(.blue, cornerValue: 13) {
                    Text("운동 시작").foregroundColor(.white)
                }
                .frame(height: AboutSize.deviceSize[1]*0.07)
            }
            Spacer()
        }
        //  MARK: -Alert
        .alert("운동 종료",isPresented: $isBackAlert) {
            Button("취소",role: .cancel){}
            Button("확인",role: .destructive){isFinish = true; mode.wrappedValue.dismiss()}
        }message: {
            Text("정말 운동을 종료하시겠습니까?")
        }
        
        //  MARK: -ViewCycle
        .onAppear {
            print("DoExercise: \(choiceRoutine)")
            vm.choiceRoutine = choiceRoutine
            UINavigationController.disableScroll = true
        }
        .onDisappear {
            if isFinish {
                mainVm.stopTime()
            }
            UINavigationController.disableScroll = false
        }
        
        //  MARK: -Toolbar
        .navigationBarBackButtonHidden(true)
        .navigationTitle("\(choiceRoutine.name)")
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
                        mainVm.startTime {
                            vm.totalTime += 1
                        }
                        isStop.toggle()
                    }label: {
                        Text("재시작")
                    }
                } else{
                    if isFirstStart {
                        Button {
                            mainVm.stopTime()
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
}

struct DoExerciseIndex: View {
    @Binding var exercise: RoutineExerciseModel
    var body: some View {
        RoundedRecView(.purple.opacity(0.5), cornerValue: 13) {
            VStack {
                HStack{
                    Spacer()
                    Text(exercise.exercise)
                    Spacer()
                    Button {
                        
                    }label: {
                        Image(systemName: "ellipsis")
                    }
                }
                CustomListView {
                    ForEach(1..<exercise.setCount+1, id:\.self) { i in
                        Text("\(i)세트  키로. 횟수 체크").foregroundColor(.black)
                    }
                }
                Spacer()
            }
        }
        .frame(height: AboutSize.deviceSize[1]*0.25)
    }
}
