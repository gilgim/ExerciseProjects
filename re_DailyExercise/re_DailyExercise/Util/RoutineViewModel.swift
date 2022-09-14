//
//  RoutineViewModel.swift
//  re_DailyExercise
//
//  Created by KimWooJin on 2022/08/29.
//

import Foundation

class RoutineViewModel: ObservableObject {
    //  기본 모델
    @Published var model = RoutineModel()
    //  루틴들
    @Published var routines: [RoutineModel] = []
    //  루틴 생성 시 선택되는 운동들
    @Published var selectedExercises: [ExerciseModel] = []
    //  실제 루틴 뷰에 삽입되어진 운동들
    @Published var choiceExercises: [RoutineExerciseModel] = []
    //  저장 실패 시 알림 // 운동을 중복으로 선택하거나, 알 수 없는 오류 발생 시 true
    @Published var createAlertBool: Bool = false
    //  유저가 입력하는 운동 세트 수
    @Published var inputSetString: String = ""
    var inputSet: Int {
        get {
            return Int(inputSetString) ?? 0
        }
    }
    var tempInputSet: String {
        get {
            return inputSetString
        }
        set {
            DispatchQueue.main.async {
                self.inputSetString = newValue
                if !self.inputSetString.allSatisfy({$0.isNumber}) {
                    self.inputSetString = ""
                }
                if self.inputSetString.count > 3 {
                    self.inputSetString.removeLast()
                }
            }
        }
    }
    //  유저가 입력하는 운동 휴식시간
    @Published var inputRestTimeString: String = ""
    var inputRestTime: Int {
        get {
            return Int(inputRestTimeString) ?? 0
        }
    }
    var tempInputRestTime: String {
        get {
            return inputRestTimeString
        }
        set {
            DispatchQueue.main.async {
                self.inputRestTimeString = newValue
                if !self.inputRestTimeString.allSatisfy({$0.isNumber}) {
                    self.inputRestTimeString = ""
                }
                if self.inputRestTimeString.count > 4 {
                    self.inputRestTimeString.removeLast()
                }

            }
        }
    }
}
//  MARK: -Function about model
extension RoutineViewModel {
    func createRoutine() {
        /**
         새로운 루틴을 추가하는 함수
         */
        for (i, choiceExercise) in choiceExercises.enumerated() {
            guard choiceExercise.exercise != "" && choiceExercise.setCount != 0  && choiceExercise.restTime != 0 else {
                self.createAlertBool = true
                return}
            let nowDate = Date()
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "/yyyy/MM/dd/HH"
            let dateString = dateFormat.string(from: nowDate)
            choiceExercises[i].name = choiceExercise.exercise + String(choiceExercise.restTime) + String(choiceExercise.setCount) + dateString
        }
        model.choiceExercises = choiceExercises
        self.model.addRealm(targetModel: self.model) { error in
            if error == nil {
                createAlertBool = false
                print("Add Realm about \(self.model)")
            }
            else {
                createAlertBool = true
                print("\(String(describing: error?.rawValue)) : Not add Realm about \(self.model)")
            }
        }
    }
    /**
     Realm에서 데이터를 불러와서 뷰에게 제공하는 형태로 바꾸는 함수
     */
    func readRoutines(key:String = "") -> [RoutineModel] {
        var routines = self.model.readRealm() { error in
            if error != nil {
                print("\(String(describing: error?.rawValue))")
            }
        }
        print(routines)
        if key != "" {
            var tempRoutines: [RoutineModel] = []
            for routine in routines {
                if routine.name.contains(key) {
                    tempRoutines.append(routine)
                }
            }
            routines = tempRoutines
        }
        return routines
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
    func deleteRoutine(targetModel: RoutineModel){
        self.model.deleteRealm(targetModel: targetModel) { error in
            if error == nil {
                print("Delete Seccess about \(targetModel)")
            }
        }
    }
    /**
     선택한 운동 객체을 한번에 삭제하는 함수
     */
    func deleteRoutines(targetModels: [RoutineModel]){
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
    func updateRoutinesFromRealm(key: String = "") {
        self.routines = self.readRoutines(key: key)
    }
}
//  MARK: -Function about view
extension RoutineViewModel {
    func choiceToReal() {
        let names = selectedExercises.map{return $0.name}
        if choiceExercises.isEmpty {
            for name in names {
                choiceExercises.append(RoutineExerciseModel(exercise: name))
            }
        }else {
            for name in names {
                if !choiceExercises.contains(where: { RoutineExerciseModel in
                    if RoutineExerciseModel.exercise == name {
                        return true
                    }
                    else {
                        return false
                    }})
                {
                    choiceExercises.append(RoutineExerciseModel(exercise: name))
                }
            }
        }
        print("Routine : \(choiceExercises)")
    }
    func removeList(at offsets: IndexSet) {
        self.choiceExercises.remove(atOffsets: offsets)
    }
    func moveList(from source: IndexSet, to destination: Int) {
        self.choiceExercises.move(fromOffsets: source, toOffset: destination)
    }
}
