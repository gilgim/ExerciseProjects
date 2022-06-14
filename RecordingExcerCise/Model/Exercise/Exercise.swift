//
//  Exercise.swift
//  RecordingExcerCise
//
//  Created by KimWooJin on 2022/05/12.
//

import Foundation
import RealmSwift
enum Equipment : String, CaseIterable{
    case babel = "바벨"
    case dumbbell = "덤벨"
    case machine = "머신"
    case nake = "맨몸"
}
/**
 신체 부위 나누는 것
 */
enum BodyPart : String , CaseIterable{
    case chest = "가슴"
    case back = "등"
    case shoulder = "어깨"
    case lower_Body = "하체"
    case arm = "팔"
    case abs = "복근"
}
class Exercise : Object{
    /**
     운동명
     */
    @objc dynamic var name : String?
    /**
     동작설명
     */
    @objc dynamic var explainExcercise : String?
    /**
     운동부위
     */
    @objc dynamic var exercisePart : String?
    /**
     장비
     */
    @objc dynamic var equipment : String?
    /**
     운동 유튜브 링크
     */
    @objc dynamic var exerciseLink : String?
}
/**
    운동만드는 함수 예) 벤치프레스, 부위, 설명 등등
 */
func createExercisePart(name:String = "", explain:String = "", equipment:Equipment = .babel, part:BodyPart = .chest, link:String = ""){
    let realm = try! Realm()
    let exercise = Exercise()
    exercise.name = name
    exercise.explainExcercise = explain
    exercise.equipment = equipment.rawValue
    exercise.exercisePart = part.rawValue
    exercise.exerciseLink = link
    try! realm.write{
        realm.add(exercise)
    }
}
