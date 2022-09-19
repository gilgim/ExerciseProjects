//
//  RoutineView.swift
//  re_DailyExercise
//
//  Created by KimWooJin on 2022/08/29.
//

import Foundation
import SwiftUI

struct RoutineView: View {
    @Environment(\.presentationMode) var mode
    @StateObject var vm = RoutineViewModel()
    @State var isSelect = false
    @State var selectRoutine: [RoutineModel] = []
    @State var notAniIsSelect = false
    @State var isAlert = false
    @State var searchText = ""
    @Binding var isSheet: Bool
    @Binding var sheetRoutines: [RoutineModel]
    init(isSheet: Binding<Bool> = .constant(false),
         selectRoutine: Binding<Array<RoutineModel>> = .constant([])) {
        self._isSheet = isSheet
        self._sheetRoutines = selectRoutine
    }
    var body: some View {
        SearchBar(text: $searchText) {
            vm.updateRoutinesFromRealm(key: searchText)
        }
        SafeVStack {
            ScrollView {
                ForEach($vm.routines,id: \.name) { $routine in
                    RoutineIndexView(routines: $selectRoutine,
                                      routine: $routine,
                                      isSelect: $notAniIsSelect) {
                        vm.updateRoutinesFromRealm()
                    }
                }
                if !notAniIsSelect {
                    NavigationLink {
                        RoutineCreatView()
                    }label: {
                        RoundedRecView(.blue, cornerValue: 13) {
                            Image(systemName: "plus").foregroundColor(.black)
                                .padding()
                        }
                        .frame(height: AboutSize.deviceSize[1]*0.07)
                    }
                }
            }
        }
        .onAppear {
            isSelect = false
            selectRoutine = []
            notAniIsSelect = false
            isAlert = false
            searchText = ""
            vm.updateRoutinesFromRealm()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("루틴 목록")
        .navigationBarBackButtonHidden(notAniIsSelect)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                if self.notAniIsSelect {
                    Button {
                        withAnimation {
                            self.isSelect.toggle()
                        }
                        self.notAniIsSelect.toggle()
                        self.selectRoutine = []
                    }label: {
                        Text("취소")
                    }
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button{
                    if !vm.routines.isEmpty {
                        if self.isSelect {
                            self.vm.deleteRoutines(targetModels: self.selectRoutine)
                            self.vm.updateRoutinesFromRealm()
                        }
                        withAnimation {
                            self.isSelect.toggle()
                        }
                        self.notAniIsSelect.toggle()
                    }else {
                        self.isAlert = true
                    }
                }label: {
                    Text(self.notAniIsSelect ? "삭제하기":"선택")
                        .foregroundColor(self.notAniIsSelect ? self.notAniIsSelect && selectRoutine.isEmpty ? .gray:.red:.blue)
                }
                .disabled(notAniIsSelect && selectRoutine.isEmpty)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                if isSheet {
                    Button{
                        self.isSheet = false
                    }label: {
                        Image(systemName: "xmark")
                    }
                }
            }
        }
        .padding(.horizontal,16)
        .alert("오류",isPresented: $isAlert) {
            Button("확인"){}
        }message: {
            Text("저장된 루틴이 없습니다.")
        }
    }
}
struct RoutineIndexView: View {
    @StateObject var vm: RoutineViewModel = RoutineViewModel()
    @Binding var routines: [RoutineModel]
    @Binding var routine: RoutineModel
    @Binding var isSelect: Bool
    @State var selectObject: Bool = false
    @State var isNavigationLink: Bool = false
    @State var isDoExercise: Bool = false
    let action: ()->()
    init(routines: Binding<Array<RoutineModel>>, routine: Binding<RoutineModel>,
         isSelect: Binding<Bool>,
         action: @escaping () -> Void) {
        self._routines = routines
        self._routine = routine
        self._isSelect = isSelect
        self.action = action
    }
    var body: some View {
        ContentIndexView(.purple,corner: 13
                         ,wholeIsSelect: $isSelect, selectObject: $selectObject){
            vm.deleteRoutine(targetModel: routine)
            action()
        }content: {
            HStack {
                Text(routine.name).foregroundColor(.black)
            }
            .background {
                NavigationLink(destination: DoExerciseView(mainVm: MainView.vm, choiceRoutine: $routine), isActive: $isNavigationLink) {
                    EmptyView()
                }
            }
        }
        .frame(height: AboutSize.deviceSize[1]*0.1)
        .onAppear {
            print(routine)
        }
        .onChange(of: routines.count) { _ in
            if routines.isEmpty {
                selectObject = false
            }
        }
        .onTapGesture {
            if isSelect {
                self.selectObject.toggle()
                if selectObject {
                    self.routines.append(self.routine)
                }else {
                    self.routines = self.routines.filter {
                                        if $0.name != routine.name {
                                            return true
                                        }else {
                                            return false
                                        }
                                    }
                }
            }
            else {
                isDoExercise.toggle()
            }
        }
        .alert("운동 시작",isPresented: $isDoExercise) {
            Button("취소"){}
            Button("확인"){isNavigationLink.toggle()}
        }message: {
            Text("\"\(routine.name)\" 루틴을 시작하시겠습니까?")
        }
    }
}
struct RoutineCreatView: View {
    @State var isSheet: Bool = false
    @Environment(\.presentationMode) var mode
    @StateObject var vm = RoutineViewModel()
    let colors: [Color] = [.white,.purple,.white]
    var body: some View {
        SafeVStack(colors) {
            ScrollView {
                TitleView(title: "루틴 명") {
                    RoundedRecView(.white, cornerValue: 13) {
                        TextField("루틴 명",text: $vm.model.name)
                            .padding()
                    }
                }
                TitleView(title: "운동") {
                    CustomListView {
                        ForEach($vm.choiceExercises,id: \.exercise) { realExercise in
                            ChoiceIndexView(realExercise: realExercise) {
                                
                            }
                        }
                        .onDelete(perform: vm.removeList)
                        .onMove(perform: vm.moveList)
                        Button {
                            isSheet.toggle()
                        }label: {
                            RoundedRecView(.blue, cornerValue: 13) {
                                Image(systemName: "plus")
                            }
                        }
                    }
                }.frame(height: AboutSize.deviceSize[1]*0.7)
            }
        }
        .navigationTitle("루틴 생성")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    vm.createRoutine()
                    if !vm.createAlertBool {
                        mode.wrappedValue.dismiss()
                    }
                }label: {
                    Text("완료")
                }
            }
        }
        .sheet(isPresented: $isSheet)
        {
            NavigationView {
                VStack{
                    ExerciseView(isSheet: $isSheet,sheetExercises: $vm.selectedExercises)
                        .onAppear {
                            vm.selectedExercises = []
                        }
                        .onDisappear {
                            vm.choiceToReal()
                        }
                    Spacer()
                }
            }
        }
        .alert("오류",isPresented: $vm.createAlertBool) {
            Button("확인"){}
        }message: {
            Text(vm.errorMessege)
        }
    }
}
struct ChoiceIndexView: View {
    @StateObject var vm = RoutineViewModel()
    @Binding var realExercise: RoutineExerciseModel
    let disAppearAction: () -> ()
    init(realExercise: Binding<RoutineExerciseModel>, disAppearAction: @escaping () -> Void) {
        self._realExercise = realExercise
        self.disAppearAction = disAppearAction
    }
    var body: some View {
        HStack {
            Text(realExercise.exercise).padding()
            TextField("",text: $vm.tempInputSet)
                .keyboardType(.numberPad).foregroundColor(.black).background(.gray)
            TextField("",text: $vm.tempInputRestTime)
                .keyboardType(.numberPad).foregroundColor(.black).background(.gray)
        }
        .onChange(of: vm.inputRestTime) { newValue in
            print(realExercise.restTime)
            realExercise.restTime = newValue
        }
        .onChange(of: vm.inputSet) { newValue in
            realExercise.setCount = vm.inputSet
            print(realExercise.setCount)
        }
    }
}
