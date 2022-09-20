//
//  ExerciseView.swift
//  re_DailyExercise
//
//  Created by KimWooJin on 2022/08/25.
//

import SwiftUI
import RealmSwift

//  MARK: -운동 뷰
struct ExerciseView: View {
    @Environment(\.presentationMode) var mode
    @StateObject var vm = ExerciseViewModel()
    @State var isSelect = false
    @State var selectExercises: [ExerciseModel] = []
    @State var notAniIsSelect = false
    @State var isAlert = false
    @State var searchText = ""
    @Binding var isSheet: Bool
    @Binding var sheetExercises: [ExerciseModel]
    @State var qickSearch: String = ""
    let qickArray: [String] = ["즐겨찾기 운동", "가슴", "등", "어깨", "팔", "복근"]
    init(isSheet: Binding<Bool> = .constant(false),
         sheetExercises: Binding<Array<ExerciseModel>> = .constant([])) {
        self._isSheet = isSheet
        self._sheetExercises = sheetExercises
    }
    var body: some View {
        //  운동목록
        SafeVStack([.safeTopBottomColor,.safeMainColor,.safeTopBottomColor]) {
            //  키보드검색바
            SearchBar(text: $searchText) {
                vm.updateExercisesFromRealm(type: .keyboard, key: searchText)
            }
            .padding(.vertical,AboutSize.deviceSize[1]*0.012)
            //  퀵 검색바
            KeywordSearchView(array: qickArray, text: $qickSearch) {
                vm.updateExercisesFromRealm(type: .button, key: qickSearch)
            }
            .padding(.bottom,AboutSize.deviceSize[1]*0.024)
            ScrollView(showsIndicators: false) {
                ForEach($vm.exercises,id: \.name) { $exercise in
                    ExerciseIndexView(exercises: $selectExercises,
                                      exercise: $exercise,
                                      isSelect: $notAniIsSelect,
                                      isSheet: $isSheet) {
                        vm.updateExercisesFromRealm()
                    }
                    .shadow(color: .almostShadowColor.opacity(0.2), radius: 4,y: 3)
                    .padding(.horizontal,16)
                    .padding(.bottom,AboutSize.deviceSize[1]*0.024)
                }
                if !notAniIsSelect {
                    NavigationLink {
                        ExerciseCreateView()
                    }label: {
                        RoundedRecView(.white, cornerValue: 13) {
                            Image(systemName: "plus").foregroundColor(.black)
                                .padding()
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, AboutSize.deviceSize[1]*0.006)
                        .frame(height: AboutSize.deviceSize[1]*0.057)
                    }
                }
            }
            if notAniIsSelect {
                if !isSheet {
                    NavigationLink {
                        ExerciseCreateView()
                    }label: {
                        RoundedRecView(selectExercises.isEmpty ? .gray : .blue, cornerValue: 13) {
                            Text("운동하기").foregroundColor(.white)
                        }
                        .frame(height: AboutSize.deviceSize[1]*0.07)
                        .padding(.vertical,10)
                    }
                    .disabled(selectExercises.isEmpty)
                }
                else {
                    Button {
                        isSheet = false
                        sheetExercises = selectExercises
                    }label: {
                        RoundedRecView(.blue, cornerValue: 13) {
                            Text("추가하기").foregroundColor(.white)
                        }
                        .frame(height: AboutSize.deviceSize[1]*0.07)
                    }
                }
            }
        }
        .onAppear {
            isSelect = false
            selectExercises = []
            notAniIsSelect = false
            isAlert = false
            searchText = ""
            vm.updateExercisesFromRealm()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(isSheet ? "선택하기":"운동 목록")
        .navigationBarBackButtonHidden(notAniIsSelect)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button{
                    if !vm.exercises.isEmpty {
                        if self.notAniIsSelect {
                            self.vm.deleteExercises(targetModels: self.selectExercises)
                            self.vm.updateExercisesFromRealm()
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
                        .foregroundColor(self.notAniIsSelect ? self.notAniIsSelect && selectExercises.isEmpty ? .gray:.red:.almostFontColor)
                }
                .disabled(notAniIsSelect && selectExercises.isEmpty)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                if !isSheet {
                    if notAniIsSelect {
                        Button{
                            self.selectExercises = []
                            self.notAniIsSelect.toggle()
                            self.isSelect.toggle()
                        }label: {
                            Text("취소")
                        }
                    }
                }
                else {
                    if notAniIsSelect {
                        Button {
                            self.selectExercises = []
                            self.notAniIsSelect.toggle()
                            self.isSelect.toggle()
                        }label: {
                            Text("취소")
                        }
                    } else {
                        Button{
                            self.isSheet = false
                        }label: {
                            Image(systemName: "xmark")
                        }
                    }
                }
            }
        }
        .alert("오류",isPresented: $isAlert) {
            Button("확인"){}
        }message: {
            Text("저장된 운동이 없습니다.")
        }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView()
    }
}
//  MARK: -운동 구성 인덱스 뷰
struct ExerciseIndexView: View {
    @StateObject var vm: ExerciseViewModel = ExerciseViewModel()
    @Binding var exercises: [ExerciseModel]
    @Binding var exercise: ExerciseModel
    @Binding var isSelect: Bool
    @Binding var isSheet: Bool
    @State var selectObject: Bool = false
    let action: ()->()
    init(exercises: Binding<Array<ExerciseModel>>, exercise: Binding<ExerciseModel>,
         isSelect: Binding<Bool>, isSheet: Binding<Bool> = .constant(false),
         action: @escaping () -> Void) {
        self._exercises = exercises
        self._exercise = exercise
        self._isSelect = isSelect
        self._isSheet = isSheet
        self.action = action
    }
    var body: some View {
        ContentIndexView(.white,corner: 15
                         ,wholeIsSelect: $isSelect, selectObject: $selectObject){
            vm.deleteExercise(targetModel: exercise)
            action()
        }content: {
            HStack {
                RoundedRecView(.fixObjectColor, cornerValue: 13) {
                    Text("\(exercise.part[0])")
                        .padding(.horizontal, 20)
                        .padding(.vertical,AboutSize.deviceSize[1]*0.012)
                }
                .frame(width: 70, height: AboutSize.deviceSize[1]*0.02)
                Text("\(exercise.name)")
                Spacer()
                Button {
                    
                }label: {
                    ZStack {
                        Image(systemName: "ellipsis")
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 2)
                    }
                    .frame(width: 32)
                    .padding(.trailing, 10)
                }
            }
            .padding(.horizontal, 10)
            .foregroundColor(.almostFontColor)
        }
        .frame(height: AboutSize.deviceSize[1]*0.1)
        .onChange(of: exercises.count) { _ in
            if exercises.isEmpty {
                selectObject = false
            }
        }
        .onTapGesture {
            if isSheet {
                isSelect = true
            }
            if isSelect {
                self.selectObject.toggle()
                if selectObject {
                    self.exercises.append(self.exercise)
                }else {
                    self.exercises = self.exercises.filter {
                                        if $0.name != exercise.name {
                                            return true
                                        }else {
                                            return false
                                        }
                                    }
                }
            }
        }
    }
}
// MARK: -운동 생성 뷰
struct ExerciseCreateView: View {
    @StateObject var vm = ExerciseViewModel()
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    let colors: [Color] = [.purple.opacity(0.15), .purple.opacity(0.1), .clear]
    var body: some View {
        SafeVStack(colors) {
            ScrollView {
                TitleView(title: "운동명") {
                    RoundedRecView(.white, cornerValue: 13) {
                        TextField("운동명",text: $vm.model.name)
                            .padding()
                    }
                }
                TitleView(title:"운동 설명") {
                    RoundedRecView(.white, cornerValue: 13) {
                        TextEditor(text: $vm.model.explain)
                            .padding()
                            .frame(height: AboutSize.deviceSize[1]*0.4)
                    }
                }
                RoundedRecView(.white, cornerValue: 13) {
                    Button {
                        
                    }label: {
                        HStack {
                            Spacer()
                            Text("Link")
                            Spacer()
                        }.padding()
                    }
                }.padding(.horizontal,16)
                TitleView(title:"운동 부위") {
                    CustomLazyVGird(vm.partArray, userData: $vm.model.part)
                }
                TitleView(title:"기구") {
                    CustomLazyVGird(vm.equimentArray, userData: $vm.model.equiment)
                }
            }
        }
        .navigationTitle("운동 생성")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button{
                    vm.createExercise()
                    if !vm.createAlertBool{
                        mode.wrappedValue.dismiss()
                    }
                }label: {
                    Text("저장")
                }
            }
        }
        .alert("오류",isPresented: $vm.createAlertBool) {
            Button("확인"){}
        }message: {
            Text(vm.errorMessage)
        }
    }
}
