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
    
    func createRealmObject(target: ExerciseFormStruct) {
        //  Not approve duplicated value
        guard !self.readRealmObject().contains(where: {
            $0.name == target.name
        })
        else{printErrorMessage(type: .duplicateValue);return}
        printErrorMessage(type: .none)
        do {
            let object = try target.structChangeObject()
            try self.realm.write({
                self.realm.add(object)
            })
            utilPrint(title: "Create Exercise Form") {
                print("Image Type : ",separator: " ")
                if object.sfSymbolName != IDKeyword.UiImage.rawValue {print("SFSymbol")}
                else {print("UserImage")}
                print("name : \(object.name!)")
                print("explain : \(object.explain ?? "Empty")")
                print("link : \(object.link ?? "Empty")")
                print("part : \(object.part)")
                print("detailPart : \(object.detailPart)")
                print("equipment : \(object.equipment)")
            }
        }
        catch {
            catchMessage(error)
        }
    }
    /// the reason this stage contain calling up image is because if data is saved realm, phone disk can be be short of size
    func readRealmObject() -> [ExerciseFormStruct] {
        return realm.objects(ExerciseFormObject.self).map({
            var structObject = $0.objectChangeStruct()
            if structObject.sfSymbolName == IDKeyword.UiImage.rawValue {
                let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
                let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
                let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
                
                if let directoryPath = path.first {
                    if let name = structObject.name {
                        let fileName = IDKeyword.ExerciseFormImage.rawValue + name
                        let imageURL = URL(fileURLWithPath: directoryPath).appendingPathComponent(fileName)
                        structObject.image = UIImage(contentsOfFile: imageURL.path)
                    }
                }
            }
            else if structObject.sfSymbolName == nil {
                if let parts = structObject.part {
                    structObject.sfSymbolName = bodyPartDefaultSymbol(parts: parts)
                }
            }
            return structObject
        })
    }
    
    func updateRealmObject(from: ExerciseFormStruct, to: ExerciseFormStruct) {
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
    
    func deleteRealmObject(target: ExerciseFormStruct) {
        let id = target.keyValue()
        guard let object = self.realm.object(ofType: ExerciseFormObject.self, forPrimaryKey: id)
        else {
            utilPrint(title: "Delete Exercise Form") {
                print("Do not delete")
            }
            return
        }
        do {
            try self.realm.write({
                self.realm.delete(object)
            })
            utilPrint(title: "Delete Exercise Form") {
                print("Id : \(id!)")
            }
        }
        catch {
            catchMessage(error)
        }
        if target.sfSymbolName == IDKeyword.UiImage.rawValue {
            guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
            let imageURL = documentDirectory.appendingPathComponent(IDKeyword.ExerciseFormImage.rawValue + target.name!)
            utilPrint(title: "Exercise Form Image Delete") {
                if FileManager.default.fileExists(atPath: imageURL.path) {
                    do {
                        try FileManager.default.removeItem(at: imageURL)
                        print("Image name : \(IDKeyword.ExerciseFormImage.rawValue + target.name!)")
                    } catch {
                        catchMessage(error)
                    }
                }
            }
        }
    }
    /// This function do to save exercise form image.
    func saveImageToDocumentDirectory(imageName: String, imageData: Data?) {
        utilPrint(title: "ImageSave") {
            guard let data = imageData else {print("Image is empty.");return}
            guard let documentDirctory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
            let imageURL = documentDirctory.appendingPathComponent(IDKeyword.ExerciseFormImage.rawValue+imageName)
            
            //  If this imageName duplicate, this content is deleted
            if FileManager.default.fileExists(atPath: imageURL.path) {
                do {
                    try FileManager.default.removeItem(at: imageURL)
                    print("This content duplicate. so image is deleted.")
                }
                catch {
                    catchMessage(error)
                }
            }
            // Save content
            do {
                try data.write(to: imageURL)
                print("Writing data success.")
            }
            catch {
                catchMessage(error)
            }
        }
    }
}

struct ExerciseFormStruct: SwiftObject {
    typealias realmObject = ExerciseFormObject
    /// This image is only two types that are icon or user photo.
    var sfSymbolName: String?
    var image: UIImage?
    
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
    var favorite: Bool = false
    
    /// Don't chagne detailpart object, because it is Object Class that action error.
    func structChangeObject() throws -> ExerciseFormObject {
        //  Check empty value
        guard let name, name != "",
              let part, let detailPart, let equipment
        else {throw ErrorType.valueIsEmpty}
        
        //  Realm Object
        let object = ExerciseFormObject()
        object.sfSymbolName = sfSymbolName
        object.name = name
        object.part.append(objectsIn: part)
        object.equipment.append(objectsIn: equipment)
        object.detailPart.append(objectsIn: try detailPart.map({
            var result = ""
            if let id = try $0.structChangeObject().id {
                result = id
            }
            return result
        }))
        //  If explain value is "" and link value is "", values change to nil
        object.explain = self.explain
        if explain == "" {object.explain = nil}
        
        object.link = self.link
        if link == "" {object.link = nil}
        
        object.id = IDKeyword.ExerciseForm.rawValue + name
        return object
    }
    func keyValue() -> String? {
        guard let name else {return nil}
        return IDKeyword.ExerciseForm.rawValue + name
    }
}
/// Assume that no empty valuse are stored
/// This object will be used for Saving user data
class ExerciseFormObject:Object, CutomRealmObject {
    typealias swiftObject = ExerciseFormStruct
    
    /// ID is make of name and date
    @Persisted(primaryKey: true) var id: String?
    
    @Persisted var sfSymbolName: String?
    /// Exercise name can't be duplicated component.
    @Persisted var name: String?
    
    /// Exercise explain can contain nil.
    @Persisted var explain: String?
    
    /// Link can contain nil.
    @Persisted var link: String?
    
    /// Part can contain many component.
    @Persisted var part = List<BodyPart>()
    @Persisted var detailPart = List<String>()
    @Persisted var equipment = List<Equipment>()
    @Persisted var favorite: Bool
    
    func objectChangeStruct() -> ExerciseFormStruct {
        var object = ExerciseFormStruct()
        object.sfSymbolName = sfSymbolName
        object.name = name
        object.explain = explain
        object.link = link
        object.part = Array(part)
        
        let realm = try! Realm()
        let realmObject = Array(detailPart).map({
            var result = DetailPartObject()
            if let object = realm.object(ofType: DetailPartObject.self, forPrimaryKey: $0) {
                result = object
            }
            return result.objectChangeStruct()
        })
        object.detailPart = realmObject
        object.equipment = Array(equipment)
        object.favorite = favorite
        
        return object
    }
}
