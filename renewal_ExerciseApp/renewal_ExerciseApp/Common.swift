//
//  Common.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/10/24.
//

import Foundation
import RealmSwift

/// Exception Error Types
enum ErrorType: Error {
    /// Contain Nil or "" etc...
    case valueIsEmpty
    
    /// Error encounted during lookup  : Realm Object component contain empty value.
    case readError
    
    /// Not finding Realm file
    case realmFindError
    
}

/// Kind of body part
enum BodyPart: String, PersistableEnum {
    case Chest = "가슴", Back = "등", Arms = "팔", lowerBody = "하체", Abs = "복근", wholeBody = "전신", aerobic = "유산소"
}

/// Program should print error message
enum ErrorMessage: String {
    
    /// If your realm objects can't be duplicated values, you select this error
    case duplicateValue = "이미 존재하는 값 입니다."
}
func errorMessage(type: ErrorMessage) {
    print("ERROR : \(type.rawValue)")
}
func catchMessage<T>(_ value: T) {
    print(value)
}
