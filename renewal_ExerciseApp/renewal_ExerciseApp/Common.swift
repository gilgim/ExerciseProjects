//
//  Common.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/10/24.
//

import Foundation
import RealmSwift
import SwiftUI

/// Exception Error Types
enum ErrorType: Error {
    /// Contain Nil or "" etc...
    case valueIsEmpty
    
    /// Error encounted during lookup  : Realm Object component contain empty value.
    case readError
    
    /// Not finding Realm file
    case realmFindError
    
    /// Creating Error
    case createError(String)
}
/// Program should print error message
enum ErrorMessage: String {
    case none = "None"
    /// If your realm objects can't be duplicated values, you select this error
    case duplicateValue = "이미 존재하는 값 입니다."
}
/// This Error is runtime error.
func catchMessage<T>(_ value: T) {
    print("Catch ERROR : \(value)")
}
////  Error Struct
struct ErrorControl {
    static var errorMessage: ErrorMessage = .none
}
/// This function print user error. it don't print runtime error.
func printErrorMessage(type: ErrorMessage) {
    ErrorControl.errorMessage = type
    if type != .none {
        print("ERROR : \(type.rawValue)")
    }
}
/// Kind of body part
enum BodyPart: String, PersistableEnum {
    case Chest = "가슴", Back = "등", Arms = "팔", lowerBody = "하체", Abs = "복근", wholeBody = "전신", aerobic = "유산소"
}
/// Kind of equipment
enum Equipment: String, PersistableEnum {
    case babell = "바벨", dumbbel = "덤벨", machine = "머신", bareBody = "맨몸"
}
///  One set should only two types that are "exercise" and "rest"
enum SetContentType: String, PersistableEnum {
    case Exercise = "운동", Rest = "휴식"
}
func utilPrint(title: String, completion: @escaping () -> ()) {
    print("========== < \(title) > ==========")
    completion()
    print("==========================\(title.map({_ in return "="}).joined())")
}
//  Action closure 
func actionClosure(action:(()->())?) {
    guard let action else {return}
    action()
}
// FIXME: 여기까지 날짜 바꾸는 함수 생성
func dateString() -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = ""
    return ""
}
