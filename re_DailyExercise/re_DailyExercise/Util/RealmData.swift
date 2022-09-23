//
//  RealmData.swift
//  re_DailyExercise
//
//  Created by KimWooJin on 2022/08/26.
//

import Foundation
import RealmSwift

public enum ErrorMessage: String {
    /**
     Realm 객체 저장 시 입력 값이 "" 이거나 넣어진 값이 없을 때 저장하지 않는 다는 걸 알려주는 에러
     */
    case realmIdentiferError = "입력 값이 공백이나 nil 입니다.객체가 저장되지않았습니다."
    /**
     데이터 생성 시 이미 있는 기본 키를 사용했을 때 발생하는 에러
     */
    case realmAddFail = "이미 있는 기본 키 입니다. 생성이 아닌 업데이트를 사용해주세요."
    /**
     업데이트 시 사용자가 원하는 키가 존재하지 않을 떄 나는 에러
     */
    case realmUpdateError = "기본 키가 존재하지 않습니다."
    /**
     해당 객체를 지우지 못할 때 발생하는 에러
     객체가 존재하지 않을 때 주로 발생한다.
     */
    case realmDeleteError = "해당 객체를 삭제할 수 없습니다."
    /**
     알 수 없는 에러
     */
    case idontknow = "알 수 없는 에러"
    /**
     사용하지 않는 기능
     */
    case notUsingFunction = "사용하지 않는 함수"
}
/**
 Realm CRUD를 정리 해놓은 프로토콜
 */
public protocol RealmCRUD {
    associatedtype structObject: Model

    //  Creat
    func addRealm(targetModel: structObject, notify: (ErrorMessage?)->())
    //  Read
    mutating func readRealm(keyName: String?, notify: (ErrorMessage?)->())->[structObject]
    //  Update
    func updateRealm(targetModel: structObject, notify: (ErrorMessage?)->())
    //  Delect
    func deleteRealm(targetModel: structObject, notify: (ErrorMessage?)->())
}

public protocol Model {
    associatedtype realmObject: RealmSwift.Object
    associatedtype structObject: Model
    var name: String { get set }
    mutating func fromRealmObject(object: realmObject)->structObject
}
