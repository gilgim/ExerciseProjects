//
//  TestDouble.swift
//  Router
//
//  Created by KimWooJin on 2022/12/23.
//

import Foundation

struct TestDouble {
    static func exercise() -> [ExerciseFormStruct] {
        var array: [ExerciseFormStruct] = []
        array.append(.init(name: "이미지 없음", parts: [.Chest], equipments: [.dumbbel]))
        array.append(.init(imageName: "figure.strengthtraining.traditional", name: "이미지만 있음", parts: [.Back], equipments: [.dumbbel]))
        array.append(.init(imageColorName: "2da2e1", name: "색상만 있음", parts: [.Back, .Chest], equipments: [.dumbbel]))
        array.append(.init(imageName: "figure.strengthtraining.traditional", imageColorName: "2da2e1", name: "둘다 있음", parts: [.Back], equipments: [.dumbbel]))
        return array
    }
}
