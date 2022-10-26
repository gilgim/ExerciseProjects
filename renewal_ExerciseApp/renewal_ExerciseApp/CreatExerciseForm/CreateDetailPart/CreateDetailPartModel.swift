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
    
    var swiftStruct = DetailPartStruct()
    let realm = try! Realm()
    
    /// Create one object that is detail part type
    func createRealmObject(target: swiftObject) {
        DispatchQueue.main.async {
            
            //  Not approve duplicated value
            guard !self.readRealmObject().contains(where: {$0.name == target.name})
            else{errorMessage(type: .duplicateValue);return}
            
            do {
                try self.realm.write({
                    self.swiftStruct = target
                    let object = try self.swiftStruct.structChangeObject()
                    self.realm.add(object)
                })
            }
            catch {
                print(error)
            }
        }
    }
    
    /// Read all objects that is detail part type
    func readRealmObject() -> [swiftObject] {
        return realm.objects(DetailPartObject.self).map({$0.objectChangeStruct()})
    }
    
    /// Update one object that is detail part type
    func updateRealmObject(from: swiftObject, to: swiftObject) {
        DispatchQueue.main.async {
            do {
                try self.realm.write({
                    self.swiftStruct = from
                    var object = try self.swiftStruct.structChangeObject()
                    self.realm.delete(object)
                    
                    self.swiftStruct = to
                    object = try self.swiftStruct.structChangeObject()
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
                    self.swiftStruct = target
                    var object = try self.swiftStruct.structChangeObject()
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
    
        var object = DetailPartObject()
        object.name = name
        object.affiliatedPart = affiliatedPart
        object.id = name + affiliatedPart.rawValue
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
