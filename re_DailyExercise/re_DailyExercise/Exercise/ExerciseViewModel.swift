//
//  ExerciseViewModel.swift
//  re_DailyExercise
//
//  Created by KimWooJin on 2022/08/25.
//

import Foundation
import RealmSwift


class ExerciseViewModel: ObservableObject {
    let partArray = ["가슴","등","하체","어깨","팔","복근"]
    let equimentArray = ["바벨","덤벨","머신","맨몸"]
    
    @Published var model = ExerciseModel()
    @Published var exercises: [ExerciseModel] = []
    @Published var createAlertBool: Bool = false
    var errorMessage: String = ""
    func createExercise() {
        /**
         새로운 운동을 추가하는 함수
         */
        self.model.addRealm(targetModel: self.model) { error in
            if error == nil {
                createAlertBool = false
                print("Add Realm about \(self.model)")
            }
            else {
                createAlertBool = true
                print("\(String(describing: error?.rawValue)) : Not add Realm about \(self.model)")
                switch error {
                case.realmAddFail:
                    errorMessage = "이미 있는 이름입니다. 변경해주세요."
                case.realmIdentiferError:
                    if self.model.name == "" {
                        errorMessage = "이름이 입력되지 않았습니다."
                    }
                    else if self.model.part == "" {
                        errorMessage = "운동 부위가 선택되지 않았습니다."
                    }
                    else if self.model.equiment.count == 0 {
                        errorMessage = "기구가 선택되지 않았습니다."
                    }
                default:
                    errorMessage = "알 수 없는 에러입니다."
                }
            }
        }
    }
    /**
     Realm에서 데이터를 불러와서 뷰에게 제공하는 형태로 바꾸는 함수
     */
    func readExercise(type: SearchType ,key:String = "")->[ExerciseModel] {
        var exercises = self.model.readRealm() { error in
            if error != nil {
                print("\(String(describing: error?.rawValue))")
            }
        }
        guard key != "" else {return exercises}
        switch type {
        case.noSearch:
            break
        case.keyboard:
            var tempExercise: [ExerciseModel] = []
            for exercise in exercises {
                if exercise.name.contains(key) {
                    tempExercise.append(exercise)
                }
            }
            exercises = tempExercise
        case.button:
            var tempExercise: [ExerciseModel] = []
            for exercise in exercises {
                if exercise.part.contains(key) {
                    tempExercise.append(exercise)
                }
            }
            exercises = tempExercise
        }
        return exercises
    }
    /**
     개별 운동 항목의 세부항목을 업데이트 시키는 함수
     */
    func editExercise() {
        self.model.updateRealm(targetModel: self.model) { error in
            if error == nil {
                print("Update \(self.model)")
            }
            else {
                
            }
        }
    }
    /**
     기본키에 해당하는 객체를 제거하는 함수
     */
    func deleteExercise(targetModel: ExerciseModel){
        self.model.deleteRealm(targetModel: targetModel) { error in
            if error == nil {
                print("Delete Seccess about \(targetModel)")
            }
        }
    }
    /**
     선택한 운동 객체을 한번에 삭제하는 함수
     */
    func deleteExercises(targetModels: [ExerciseModel]){
        for targetModel in targetModels {
            self.model.deleteRealm(targetModel: targetModel) { error in
                if error == nil {
                    print("Delete Seccess about \(targetModel)")
                }
            }
        }
    }
    /**
     운동 목차를 생성, 삭제 시 바인딩 된 운동 목차를  업데이트하는 함수
     */
    func updateExercisesFromRealm(type: SearchType = .noSearch, key: String = "") {
        self.exercises = self.readExercise(type: type, key: key)
    }
}
