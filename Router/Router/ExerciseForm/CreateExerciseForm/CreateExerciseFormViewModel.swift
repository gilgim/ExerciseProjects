//
//  CreateExerciseFormViewModel.swift
//  Router
//
//  Created by KimWooJin on 2022/12/28.
//

import Foundation

class CreateExerciseFormViewModel: ObservableObject {
    let model = ExerciseFormModel()
    @Published var isAlert: Bool = false
    @Published var alertMessage: String = ""
    
    init() {
        CommonFunction.printTitle(title: "CreateExerciseFormViewModel Initailize", isDetail: true)
    }
    
    /// 생성 버튼을 클릭 했을 때 실행되는 함수 입니다. 객체 생성을 시도합니다.
    func clickCreateButton(object: ExerciseFormStruct) {
        CommonFunction.printTitle(title: "Exercise Create Button")
        if object.parts.count <= 0 {
            alertToggle(message: "운동 부위를 선택해주세요.")
            return
        }
        if object.equipments.count <= 0 {
            alertToggle(message: "운동 방법을 선택해주세요.")
            return
        }
        do {
            guard try model.readObject(key: object.name) == nil else {
                alertToggle(message: "해당 운동명이 존재합니다.")
                return
            }
            try model.saveObject(value: object)
        }
        catch {
            print(error)
        }
        func alertToggle(message: String) {
            self.isAlert = true
            self.alertMessage = message
            print("ExerciseForm Create Fail")
        }
    }
}
