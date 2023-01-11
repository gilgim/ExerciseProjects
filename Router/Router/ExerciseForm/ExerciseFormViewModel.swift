//
//  ExerciseFormViewModel.swift
//  Router
//
//  Created by KimWooJin on 2022/12/28.
//

import Foundation

class ExerciseFormViewModel: ObservableObject {
    let model = ExerciseFormModel()
    @Published var exerciseArray: [ExerciseFormStruct] = []
    init() {
        CommonFunction.printTitle(title: "ExerciseFormViewModel Initailize", isDetail: true)
    }
    /// 뷰가 나타날 때 운동리스트를 불러오는 함수입니다.
    func viewAppearAction() {
        CommonFunction.printTitle(title: "viewAppearAction")
        //  네비게이션 스택에 처음들어온다면 앱이 들고 있는 운동리스트를 가져옵니다.
        if let exerciseList = RouterApp.exerciseList, exerciseArray.isEmpty {
            self.exerciseArray = exerciseList
            return
        }
        //  navigation push 기능을 우선 동작하기 위한 후순위 배치 로직입니다.
        DispatchQueue.global(qos: .userInteractive).async {
            DispatchQueue.main.async {
                //  뷰와 바인딩 된 리스트를 갱신하는 로직입니다. 값이 없을 시 갱신하지 않습니다.
                guard let readArray = try? self.model.readObjects(array: self.exerciseArray) else {
                    CommonFunction.componentDetailprint()
                    print(ErrorType.RealmReadError)
                    return
                }
                self.exerciseArray = readArray
            }
        }
    }
    /// 메인 뷰가 들고 있는 운동리스트를 갱신합니다.
    func appExerciseListUpdate() {
        DispatchQueue.global().async {
            RouterApp.exerciseList = self.exerciseArray
        }
    }
}
