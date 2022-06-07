//
//  Exercise.swift
//  RecordingExcerCise
//
//  Created by KimWooJin on 2022/05/12.
//

import Foundation
import RealmSwift
enum Equipment : String {
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
    @Persisted(primaryKey: true) var name : String?
    /**
     동작설명
     */
    @Persisted var explainExcercise : String?
    /**
     운동부위
     */
    @Persisted var exercisePart : String?
    /**
     장비
     */
    @Persisted var equipment : String?
    /**
     운동 유튜브 링크
     */
    @Persisted var exerciseLink : String?
}
/**
    운동만드는 함수 예) 벤치프레스, 부위, 설명 등등
 */
func createExercisePart(){
    let realm = try! Realm()
    let exercise = Exercise()
    exercise.name = "벤치프레스"
    exercise.explainExcercise = "중앙 가슴고립, 어깨 최대한 벌리듯이"
    exercise.equipment = "바벨"
    exercise.exercisePart = "중앙 가슴"
    exercise.exerciseLink = "http://~~~~~"
    try! realm.write{
        realm.add(exercise)
    }
}
