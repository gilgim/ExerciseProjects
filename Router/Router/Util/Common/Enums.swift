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
