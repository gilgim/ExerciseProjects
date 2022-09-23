//
//  ExerciseModel.swift
//  re_DailyExercise
//
//  Created by KimWooJin on 2022/08/25.
//

import Foundation
import RealmSwift

struct ExerciseModel: Model {
    typealias realmObject = RealmObjectExercise
    typealias structObject = ExerciseModel
    let realm = try! Realm()
    
    //  저장될 변수
    var name: String
    var explain: String
    var link: String
    var part: String
	var favorite: Bool
    var detailPart: Array<String>
    var equiment: Array<String>
    
    //  초기값 할당이 필요하면 사용하기 위한 init
	init(name: String = "", explain: String = "", link: String = "", favorite: Bool = false
         ,part: String = "", detailPart: Array<String> = [], equiment: Array<String> = []) {
        self.name = name
        self.explain = explain
        self.link = link
		self.favorite = favorite
        self.part = part
        self.detailPart = detailPart
        self.equiment = equiment
    }
    //  Realm 오브젝트를 Struct로 반환해서 사용하기 위한 함수
    mutating func fromRealmObject(object: realmObject)->structObject {
        guard let name = object.value(forKey: Util.omiExercise(value: .name)) as? String,
              let explain = object.value(forKey: Util.omiExercise(value: .explain)) as? String,
              let link = object.value(forKey: Util.omiExercise(value: .link)) as? String,
              let part = object.value(forKey: Util.omiExercise(value: .part)) as? String,
			  let favorite = object.value(forKey: Util.omiExercise(value: .favorite)) as? Bool
        else {print("Not find Value");return ExerciseModel()}
        
        self.name = name
        self.explain = explain
        self.link = link
        self.part = part
		self.favorite = favorite
        self.detailPart = Array(object.detailPart)
        self.equiment = Array(object.equiment)
        
        return self
    }
}

extension ExerciseModel: RealmCRUD{
    //  C
    func addRealm(targetModel: structObject, notify: (ErrorMessage?)->()) {
        let saveObject = realmObject().fromModel(model: targetModel)
        if realm.object(ofType: realmObject.self, forPrimaryKey: saveObject.name) == nil
            && targetModel.name != "" && targetModel.part != "" && targetModel.equiment.count != 0{
            try! realm.write {
                realm.add(saveObject)
                notify(nil)
            }
        }else if targetModel.name == "" || targetModel.part == "" || targetModel.equiment.count == 0{
            notify(.realmIdentiferError)
        }else {
            notify(.realmAddFail)
        }
    }
    //  R
    mutating func readRealm(keyName: String? = nil, notify: (ErrorMessage?)->()) -> [structObject] {
        var objects: [structObject] = []
        try! realm.write {
            if let keyName {
                if let object = realm.object(ofType: realmObject.self, forPrimaryKey: keyName) {
                    objects.append(self.fromRealmObject(object: object))
                }
            }
            else {
                for object in realm.objects(realmObject.self).reversed(){
                    objects.append(self.fromRealmObject(object: object))
                }
            }
        }
        return objects
    }
    //  U
    func updateRealm(targetModel: structObject, notify: (ErrorMessage?)->()) {
        if let object = realm.object(ofType: realmObject.self, forPrimaryKey: targetModel.name) {
            try! realm.write {
                object.explain = targetModel.explain
                object.link = targetModel.link
                object.part = targetModel.part
				object.favorite = targetModel.favorite
                object.detailPart.removeAll()
                object.equiment.removeAll()
                
                object.detailPart.append(objectsIn: targetModel.detailPart)
                object.equiment.append(objectsIn: targetModel.equiment)
                notify(nil)
            }
        }
        else {
            notify(.realmUpdateError)
        }
    }
    //  D
    func deleteRealm(targetModel: structObject, notify: (ErrorMessage?)->()) {
        let realm = try! Realm()
        if let object = realm.object(ofType: realmObject.self, forPrimaryKey: targetModel.name) {
            try! realm.write{
                realm.delete(object)
            }
            notify(nil)
        }
        else {
            notify(.realmDeleteError)
        }
    }
}

final class RealmObjectExercise: Object {
    enum VariableName: String {
        case name, explain, link, part, detailPart, equiment, realSet, favorite
    }
    
    @objc var name: String = ""
    @objc var explain: String = ""
    @objc var link: String = ""
    @objc var part: String = ""
	@objc var favorite: Bool = false
    dynamic var detailPart: List<String> = List<String>()
    dynamic var equiment: List<String> = List<String>()
    override class func primaryKey() -> String? {
        return "name"
    }
    
    func fromModel(model: ExerciseModel)->RealmObjectExercise {
        self.name = model.name
        self.explain = model.explain
        self.link = model.link
        self.part = model.part
		self.favorite = model.favorite
        self.detailPart.append(objectsIn: model.detailPart)
        self.equiment.append(objectsIn: model.equiment)
        
        return self
    }
}


