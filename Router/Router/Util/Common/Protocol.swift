//
//  Protocol.swift
//  Router
//
//  Created by KimWooJin on 2022/12/28.
//

import Foundation
import RealmSwift

/// Model이 가지고 있어야할 필수 함수들과 변수들을 정의해놓은 프로토콜입니다.
protocol Model {
    /// Json으로 저장 및 불러오기 위한 객체 타입 입니다.
    associatedtype structObject: Codable
    
    /// 객체를 Realm에 저장하는 함수입니다. 올바른 값이 아닐 시 에러가 발생합니다.
    func saveObject(value: structObject) throws
    
    /**
     객체를 불러오는 함수 입니다. 필수 값 누락 시 에러가 발생합니다.
     -  parameters:
        -   array: Json decode 횟수를 줄이기 위한 값입니다.
     */
    func readObjects(array: [structObject]) throws -> [structObject]
    /// 키 값을 사용하여 단일 객체를 불러오는 함수 입니다. 값이 nil이면 저장되어있지 않은 값 입니다.
    func readObject(key: String) throws -> structObject?
    
    /// 객체 값을 업데이트하여 Realm에 저장하는 함수 입니다.
    func updateObject(value: structObject) throws
    
    /// 객체를 Realm에서 삭제하는 함수입니다.
    func deleteObject()	throws
}
protocol StructObject {
    associatedtype realmObject: RealmObject
    /// Struct 객체를 Realm 객체로 변환하는 함수입니다.
    func structToRealm() -> realmObject?
}
protocol RealmObject: Object {
    associatedtype structObject: StructObject
    /// Realm 객체를 Struct 객체로 변환하는 함수입니다.
    func realmToStruct() -> structObject?
}
