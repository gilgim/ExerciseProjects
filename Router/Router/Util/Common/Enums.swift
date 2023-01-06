//
//  Enums.swift
//  Router
//
//  Created by KimWooJin on 2022/12/18.
//

import Foundation
enum ViewType: Hashable {
    case ExerciseFormView
    case RoutineFormView
}
enum BodyPart: String, Codable, CaseIterable {
    case Chest = "가슴", Back = "등", Arms = "팔", lowerBody = "하체", Abs = "복근", wholeBody = "전신", Aerobic = "유산소"
}

enum Equipment: String, Codable, CaseIterable {
    case babell = "바벨", dumbbel = "덤벨", machine = "머신", bareBody = "맨몸"
}
/// 루틴을 구성하고 있는 최소 단위입니다.
enum RoutineComponentType: Equatable {
    /// 휴식을 나타냅니다. 시간을 가지고 있습니다.
    case Rest(time: Int)
    
    /// 운동을 나타냅니다. 조회하기 위한 이름을 가지고 있습니다.
    case Exercise(name: String)
    
    var id: UUID {
        switch self {
        case .Exercise(_):
            return UUID()
        case .Rest(_):
            return UUID()
        }
    }
    /// ComponentType Case의 따라서 String, 또는 Int 로 정해지는 값 입니다.
    var value: Any {
        switch self {
        case .Exercise(let name):
            return name
        case .Rest(let time):
            return time
        }
    }
}
