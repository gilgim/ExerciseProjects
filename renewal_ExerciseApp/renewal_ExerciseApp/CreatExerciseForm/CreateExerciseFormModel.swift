//
//  CreateExerciseFormModel.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/10/27.
//

import Foundation
import RealmSwift

class ExerciseFormModel: Model {
    typealias swiftObject = ExerciseFormStruct
    typealias realmObject = ExerciseFormObject
    
    let realm = try! Realm()
    func createRealmObject(target: ExerciseFormStruct) async {
        //  Not approve duplicated value
        guard !self.readRealmObject().contains(where: {
            $0.name == target.name
        })
        else{printErrorMessage(type: .duplicateValue);return}
        DispatchQueue.main.async {
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
    
    func readRealmObject() -> [ExerciseFormStruct] {
        return realm.objects(ExerciseFormObject.self).map({$0.objectChangeStruct()})
    }
    
    func updateRealmObject(from: ExerciseFormStruct, to: ExerciseFormStruct) async {
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
    
    func deleteRealmObject(target: ExerciseFormStruct) {
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

struct ExerciseFormStruct: SwiftObject {
    typealias realmObject = ExerciseFormObject
    
    /// This name is exercise frame for using routine
    var name: String?
    
    /// Explain can contain empty value. but if explain same "", this data will change to nil.
    var explain: String?
    
    /// This link is YouTube link.
    var link: String?
    
    /// Part should contain some "BodyPart" because real part is selected from several elements during the routine generation process.
    var part: [BodyPart]?
    
    /// Detail part should contain some "DetailPartStruct" because real detail part is selected from several elements during the routine generation process.
    var detailPart: [DetailPartStruct]?
    
    /// Equipment should contain some "Equipment enum" because real equipment is selected from several elements during the routine generation process.
    var equipment: [Equipment]?
    
    /// Favorite component is assigned by user.
    var favorite: Bool?
    
    func structChangeObject() throws -> ExerciseFormObject {
        //  Check empty value
        guard let name, name != "",
              let part, let detailPart, let equipment
        else {throw ErrorType.valueIsEmpty}
        
        //  Realm Object
        let object = ExerciseFormObject()
        object.name = name
        object.part.append(objectsIn: part)
        object.equipment.append(objectsIn: equipment)
        
        object.detailPart.append(objectsIn: try detailPart.map({
            //  Check detail part value
            guard $0.name != nil || $0.name != "" || $0.affiliatedPart != nil
            else {throw ErrorType.createError("detailPart")}
            return try! $0.structChangeObject()
        }))
        
        //  If explain value is "" and link value is "", values change to nil
        object.explain = self.explain
        if explain == "" {object.explain = nil}
        
        object.link = self.link
        if link == "" {object.link = nil}
        
        object.id = "creat_" + name
        return object
    }
}

/// Assume that no empty valuse are stored
/// This object will be used for Saving user data
class ExerciseFormObject:Object, CutomRealmObject {
    typealias swiftObject = ExerciseFormStruct
    
    /// ID is make of name and date
    @Persisted(primaryKey: true) var id: String?
    
    /// Exercise name can't be duplicated component.
    @Persisted var name: String?
    
    /// Exercise explain can contain nil.
    @Persisted var explain: String?
    
    /// Link can contain nil.
    @Persisted var link: String?
    
    /// Part can contain many component.
    @Persisted var part = List<BodyPart>()
    @Persisted var detailPart = List<DetailPartObject>()
    @Persisted var equipment = List<Equipment>()
    @Persisted var favorite: Bool?
    
    func objectChangeStruct() -> ExerciseFormStruct {
        var object = ExerciseFormStruct()
        object.name = name
        object.explain = explain
        object.link = link
        object.part = Array(part)
        object.detailPart = Array(_immutableCocoaArray: detailPart)
        object.equipment = Array(equipment)
        object.favorite = favorite
        
        return object
    }
}
