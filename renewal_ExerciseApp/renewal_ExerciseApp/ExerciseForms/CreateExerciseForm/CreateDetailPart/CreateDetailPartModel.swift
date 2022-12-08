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
    func createRealmObject(target: swiftObject) {
		//  Not approve duplicated value
		guard !self.readRealmObject().contains(where: {
			$0.name == target.name && $0.affiliatedPart == target.affiliatedPart
		})
		else{printErrorMessage(type: .duplicateValue);return}
        printErrorMessage(type: .none)
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
    
    /// Read all objects that is detail part type
    func readRealmObject() -> [swiftObject] {
        return realm.objects(DetailPartObject.self).map({$0.objectChangeStruct()})
    }
    /// Update one object that is detail part type
    func updateRealmObject(from: swiftObject, to: swiftObject) {
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
    
    /// Delete one object that is detail part type
    func deleteRealmObject(target: swiftObject) {
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
    func idNullObject()throws -> realmObject {
        //  Object should not contain emtpy value.
        guard let name, name != "", let affiliatedPart else {throw ErrorType.valueIsEmpty}
    
        let object = DetailPartObject()
        object.name = name
        object.affiliatedPart = affiliatedPart
        return object
    }
}
extension DetailPartStruct: Equatable {
    static func == (lhs: DetailPartStruct, rhs: DetailPartStruct) -> Bool {
        return lhs.name == rhs.name
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
