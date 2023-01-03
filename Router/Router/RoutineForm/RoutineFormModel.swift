//
//  RoutineFormModel.swift
//  Router
//
//  Created by KimWooJin on 2022/12/26.
//

import Foundation

struct RoutineFormStruct {
    ///    - Korean : 이미지는 아이콘과 사진이 사용된다. 특정 키워드로 구분한다. 이미지 파라미터 값이 변화되기 때문이다.
    ///    - English :
    var imageName: String
    var imageColorName: String
    ///    - Korean : 운동 이름은 중복을 허용하지 않는다.
    ///    - English :
    var name: String
    ///    - Korean : 부위 운동 속 포함된 요소 배열
    ///    - English :
    var exercises: [KindOfComponentInRoutine]
}
///    - Korean : 루틴 속 부위 운동에 포함되어있는 휴식 또는 운동으로 결정되는 스트럭쳐
///    - English :
struct KindOfComponentInRoutine: Equatable {
    enum ComponentType {
        case exercise, rest
    }
    var id = UUID()
    var type: ComponentType
    var exercise: ExerciseFormStruct?
    var rest: Int?
    init(type: ComponentType, exercise: ExerciseFormStruct? = nil, rest: Int? = nil) throws {
        switch type {
        case.exercise:
            self.type = type
            guard let exercise else{throw ErrorType.InitailizeError("Exercise is nil")}
            self.exercise = exercise
        case.rest:
            self.type = type
            guard let rest else{throw ErrorType.InitailizeError("Rest is nil")}
            self.rest = rest
        }
    }
    static func == (lhs: KindOfComponentInRoutine, rhs: KindOfComponentInRoutine) -> Bool {
        return lhs.id == rhs.id
    }
}
