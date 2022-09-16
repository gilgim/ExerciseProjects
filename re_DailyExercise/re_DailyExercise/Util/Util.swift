//
//  Util.swift
//  re_DailyExercise
//
//  Created by KimWooJin on 2022/08/25.
//

import Foundation
import UIKit
import SwiftUI
import RealmSwift
//  MARK: -App의 Scene 상태 관리 싱글톤
class AppStatusManager {
    var isActive = false
    static var shared = AppStatusManager()
}
//  MARK: -사이즈 관련 함수
struct AboutSize {
    static let deviceSize: [CGFloat] = [UIScreen.main.bounds.width,UIScreen.main.bounds.height]
}
//  MARK: -다양한 함수들
struct Util {
    /**
     림 파일 위치 확인하는 함수
     */
    static func realmURL()throws {
        let realm = try Realm()
        guard let url = realm.configuration.fileURL else{print("Not find url");return}
        print("Realm File : \(url)")
    }
    /**
     바인딩 배열에 값 추가하는 함수
     */
    static func bindingArrayAppend(_ array: inout Array<String>, value: String) {
        if array.contains(value) {
            array = array.filter{ index in return index != value}
        }else{
            array.append(value)
        }
    }
    /**
     에러 메세지
     */
    static func omiErr(value: ErrorMessage)->String {
        print(value.rawValue)
        return value.rawValue
    }
    
    //  rawValue를 생략하게 해주는 함수
    static func omiExercise(value: RealmObjectExercise.VariableName)->String {
       return value.rawValue
    }
    static func omiRoutine(value: RealmObjectRoutine.VariableName)->String {
       return value.rawValue
    }
    static func omiRoutineExercise(value: RealmObjectRoutineExerciseModel.VariableName)->String {
       return value.rawValue
    }
    static func omiDoExerciseSetDetail(value: RealmObjectDoExerciseSetDetail.VariableName)->String {
       return value.rawValue
    }
    static func omiDoExerciseDetail(value: RealmObjectDoExerciseDetail.VariableName)->String {
        return value.rawValue
    }
    static func omiDoExercise(value: RealmObjectDoExercise.VariableName)->String {
        return value.rawValue
    }
}
