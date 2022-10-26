//
//  Protocol.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/10/26.
//

import Foundation
import RealmSwift

//  Model Common Standard
protocol Model {
    associatedtype swiftObject: SwiftObject
    associatedtype realmObject: CutomRealmObject
    
    func createRealmObject(target: swiftObject)
    func readRealmObject() -> [swiftObject]
    func updateRealmObject(from: swiftObject, to: swiftObject)
    func deleteRealmObject(target: swiftObject)
}

/// Object is used for interlinking Realm
protocol SwiftObject {
    associatedtype realmObject: CutomRealmObject
    func structChangeObject()throws -> realmObject
}

///  This protocol is needed for common standard
protocol CutomRealmObject: Object {
    associatedtype swiftObject: SwiftObject
    func objectChangeStruct() -> swiftObject
}
