//
//  Util.swift
//  RecordingExcerCise
//
//  Created by KimWooJin on 2022/06/20.
//

import Foundation
import SwiftUI
import RealmSwift

struct Util{
    public static func encodingJson(){
        
    }
    public static func decodingJson(){
        
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

//  Struct 와 Object를 연결하는 프로토콜
public protocol Persistable {
    associatedtype ManagedObject: RealmSwift.Object
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}

//  해당 림에 파일를 저장하는 클래스
public final class WriteTransaction {
    private let realm: Realm
    internal init(realm: Realm) {
        self.realm = realm
    }
    public func add<T: Persistable>(_ value: T) {
        realm.add(value.managedObject())
    }
}

//  클래스 타입을 할당 하고 림을 읽어 변경할 수 있게 하는 클래스 
public final class Container {
    private let realm: Realm
    public convenience init() throws {
        try self.init(realm: Realm())
    }
    internal init(realm: Realm) {
        self.realm = realm
    }
    public func write(_ block: (WriteTransaction) throws -> Void)
    throws {
        let transaction = WriteTransaction(realm: realm)
        try realm.write {
            try block(transaction)
        }
    }
}
