//
//  CreateDetailPartModel.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/10/24.
//

import Foundation
import RealmSwift

class DetailPartModel: Model {
    typealias swiftObject = DetailPartStruct
    typealias realmObject = DetailPartObject
    
    let realm = try! Realm()
    
    /// Create one object that is detail part type
    func createRealmObject(target: swiftObject) async {
        guard !self.readRealmObject().contains(where: {
            $0.name == target.name && $0.affiliatedPart == target.affiliatedPart
        })
        else{printErrorMessage(type: .duplicateValue);return}
        printErrorMessage(type: .none)
        DispatchQueue.main.async {
            //  Not approve duplicated value
            Task {
                guard !self.readRealmObject().contains(where: {
                    $0.name == target.name && $0.affiliatedPart == target.affiliatedPart
                })
                else{printErrorMessage(type: .duplicateValue);return}
            }

            do {
                try self.realm.write({
                    let object = try target.structChangeObject()
                    self.realm.add(object)
                })
            }
            catch {
                catchMessage(error)
            }
        }
    }
    
    /// Read all objects that is detail part type
    func readRealmObject() -> [swiftObject] {
        /// 동기처리 하지 않으면 데이터를 불러오지 못해 쓰는 곳에서 에러가 발생된다.
        DispatchQueue.main.sync {
            return realm.objects(DetailPartObject.self).map({$0.objectChangeStruct()})
        }
    }
    /// Update one object that is detail part type
    func updateRealmObject(from: swiftObject, to: swiftObject) async {
        DispatchQueue.main.async {
            do {
                try self.realm.write({
                    var object = try from.structChangeObject()
                    self.realm.delete(object)
                    object = try to.structChangeObject()
                    self.realm.add(object)
                })
            }
            catch {
                catchMessage(error)
            }
        }
    }
    
    /// Delete one object that is detail part type
    func deleteRealmObject(target: swiftObject) {
        DispatchQueue.main.async {
            do {
                try self.realm.write({
                    let object = try target.structChangeObject()
                    self.realm.delete(object)
                })
            }
            catch {
                catchMessage(error)
            }
        }
    }
}

/// This struct is used by View and ViewModel
struct DetailPartStruct: SwiftObject {
    typealias realmObject = DetailPartObject
    
    var name: String?
    var affiliatedPart: BodyPart?
    
    /// Struct change to realm object.
    func structChangeObject()throws -> realmObject {
        
        //  Object should not contain emtpy value.
        guard let name, name != "", let affiliatedPart else {throw ErrorType.valueIsEmpty}
    
        let object = DetailPartObject()
        object.name = name
        object.affiliatedPart = affiliatedPart
        object.id = affiliatedPart.rawValue + "_" + name
        return object
    }
}

/// Assume that no empty valuse are stored
/// This object will be used for Saving user data
class DetailPartObject: Object, CutomRealmObject {
    typealias swiftObject = DetailPartStruct
    
    @Persisted(primaryKey: true) var id: String?
    @Persisted var name: String?
    @Persisted var affiliatedPart: BodyPart?
    
    func objectChangeStruct() -> swiftObject{
        var structObject = DetailPartStruct()
        structObject.name = self.name
        structObject.affiliatedPart = self.affiliatedPart
        return structObject
    }
}
