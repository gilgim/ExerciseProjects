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
    @State var isDelete = false
    @State var isGoExercise = false
    @State var searchText = ""
    @Binding var isSheet: Bool
    @Binding var sheetExercises: [ExerciseModel]
    @State var qickSearch: String = ""
    let colors: [Color] = [.safeTopBottomColor,.safeMainColor,.safeTopBottomColor]
    let qickArray: [String] = ["즐겨찾기 운동", "가슴", "등", "어깨", "팔", "복근"]
    init(isSheet: Binding<Bool> = .constant(false),
         sheetExercises: Binding<Array<ExerciseModel>> = .constant([])) {
        self._isSheet = isSheet
        self._sheetExercises = sheetExercises
    }
    var body: some View {
        //  운동목록
        SafeVStack(colors) {
            //  키보드검색바
            SearchBar(text: $searchText) {
                qickSearch = ""
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
                Spacer()
                if !notAniIsSelect {
                    NavigationLink {
                        ExerciseCreateView()
                    }label: {
                        RoundedRecView(.white, cornerValue: 13) {
                            Image(systemName: "plus").foregroundColor(.almostFontColor)
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
                    Button {
                        isGoExercise = true
                        withAnimation {
                            self.isSelect.toggle()
                        }
                        self.notAniIsSelect.toggle()
                    }label: {
                        RoundedRecView(selectExercises.isEmpty ? .buttonDisableGray : .buttonSelectColor, cornerValue: 13) {
                            Text("운동하기").foregroundColor(.white)
                        }
                        .frame(height: AboutSize.deviceSize[1]*0.06)
                        .padding(.vertical, AboutSize.deviceSize[1]*0.012)
                        .padding(.horizontal, 16)
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
        .background {
            NavigationLink(destination: ExerciseCreateView(), isActive: $isGoExercise) {
                EmptyView()
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
                            self.isDelete.toggle()
                        }
                        if !self.isDelete {
                            withAnimation {
                                self.isSelect.toggle()
                            }
                            self.notAniIsSelect.toggle()
                        }
                    }else {
                        self.isAlert = true
                    }
                }label: {
                    Text(self.notAniIsSelect ? "삭제하기":"선택")
                        .foregroundColor(self.notAniIsSelect ? self.notAniIsSelect && selectExercises.isEmpty ? .buttonDisableGray:.cancelRed:.almostFontColor)
                        .fontWeight(self.notAniIsSelect ? .semibold: .regular)
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
            Button("확인") {}
        }message: {
            Text("저장된 운동이 없습니다.")
        }
        .alert("삭제하기",isPresented: $isDelete) {
            Button("확인", role: .destructive) {
                self.vm.deleteExercises(targetModels: self.selectExercises)
                self.vm.updateExercisesFromRealm()
                withAnimation {
                    self.isSelect.toggle()
                }
                self.notAniIsSelect.toggle()
            }
            Button("취소", role: .cancel) {
                
            }
        }message: {
            Text("\(self.selectExercises.count)개의 운동을 삭제하시겠습니까?")
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
    @State var isDelete: Bool = false
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
        ContentIndexView(selectObject ? .buttonSelectBackColor:.white,corner: 15,
                         strokeColor: selectObject ? .buttonSelectColor : .clear, strokeLine: selectObject ? 1.5:0
                         ,wholeIsSelect: $isSelect, selectObject: $selectObject) {
            isDelete.toggle()
        }content: {
            HStack(spacing: 0) {
                RoundedRecView(.fixObjectColor, cornerValue: 13) {
                    Text("\(exercise.part)")
                        .font(selectObject ? .system(size: AboutSize.deviceSize[1]*0.018, weight: .semibold):.system(size: AboutSize.deviceSize[1]*0.018, weight: .regular))
                        .padding(.horizontal, 20)
                        .padding(.vertical,AboutSize.deviceSize[1]*0.012)
                }
                .frame(width: 70, height: AboutSize.deviceSize[1]*0.02)
                Text("\(exercise.name)")
                    .font(selectObject ? .system(size: AboutSize.deviceSize[1]*0.021, weight: .semibold):.system(size: AboutSize.deviceSize[1]*0.021, weight: .regular))
                    .foregroundColor(selectObject ? .almostFontColor:.buttonFontBlack)
                    .padding(.horizontal, 10)
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
        .alert("삭제하기", isPresented: $isDelete) {
            Button("확인", role: .destructive) {
                vm.deleteExercise(targetModel: exercise)
                action()
            }
            Button("취소", role: .cancel) {}
        }message: {
            Text("\(exercise.name)을(를) 삭제하시겠습니까?")
        }
    }
}
// MARK: -운동 생성 뷰
struct ExerciseCreateView: View {
    @StateObject var vm = ExerciseViewModel()
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    let colors: [Color] = [.safeTopBottomColor,.safeMainColor,.safeTopBottomColor]
    var body: some View {
        SafeVStack(colors) {
            ScrollView {
                TitleView(title: "운동이름") {
                    RoundedRecView(.white, cornerValue: 13) {
                        TextField("이름",text: $vm.model.name)
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
                            Image(systemName: "link.badge.plus")
                            Text("링크 생성")
                            Spacer()
                        }.padding()
                    }
                }.padding(.horizontal,16)
                TitleView(title:"운동 부위") {
                    CustomLazyVGird(vm.partArray, type: .part, selectText: $vm.model.part)
                }
                DetailPartsView(detailArray: $vm.model.detailPart, part: $vm.model.part)
                TitleView(title:"기구") {
                    CustomLazyVGird(vm.equimentArray, type: .equiment, userData: $vm.model.equiment)
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
