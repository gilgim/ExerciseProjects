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
class Exercise : Object{
    
    //  운동명
    @Persisted(primaryKey: true) var name : String?
    
    //  동작설명
    @Persisted var explainExcercise : String?
    
    //  운동부위
    @Persisted var exercisePart : String?
    
    //  장비
    @Persisted var equipment : String?
    
    //  운동 유튜브 링크
    @Persisted var exerciseLink : String?
}

//  운동부위
class ExercisePart:Object{
    
}
