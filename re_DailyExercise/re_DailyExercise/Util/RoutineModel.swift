//
//  RoutineModel.swift
//  re_DailyExercise
//
//  Created by KimWooJin on 2022/08/29.
//

import Foundation
import RealmSwift

struct RoutineModel: Model {
    typealias realmObject = RealmObjectRoutine
    typealias structObject = RoutineModel
    
    let realm = try! Realm()
    var name: String
    var choiceExercises: [RoutineExerciseModel]
    init(name: String = "" , choicExercises: [RoutineExerciseModel] = []) {
        self.name = name
        self.choiceExercises = choicExercises
    }
    mutating func fromRealmObject(object: realmObject) -> structObject {
        guard let name = object.value(forKey: Util.omiRoutine(value: .name)) as? String,
              let choiceExercises = object.value(forKey: Util.omiRoutine(value: .choiceExercises)) as? List<RealmObjectRoutineExerciseModel> else {return structObject()}
        self.name = name
        for choiceExercise in choiceExercises {
            var temp = RoutineExerciseModel()
            let tempValue = temp.fromRealmObject(object: choiceExercise)
            self.choiceExercises.append(tempValue)
        }
        return self
    }
}

extension RoutineModel: RealmCRUD {
    func addRealm(targetModel: RoutineModel, notify: (ErrorMessage?) -> ()) {
        //  C
        let saveObject = realmObject().fromModel(model: targetModel)
        if realm.object(ofType: realmObject.self, forPrimaryKey: saveObject.name) == nil && !targetModel.choiceExercises.isEmpty {
            try! realm.write {
                realm.add(saveObject)
                notify(nil)
            }
        }else if targetModel.name == "" || !targetModel.choiceExercises.isEmpty {
            notify(.realmIdentiferError)
        }else {
            notify(.realmAddFail)
        }
    }

    //  R
    mutating func readRealm(keyName: String? = nil, notify: (ErrorMessage?) -> ()) -> [structObject] {
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
    func updateRealm(targetModel: RoutineModel, notify: (ErrorMessage?) -> ()) {
        
    }
    //  D
    func deleteRealm(targetModel: RoutineModel, notify: (ErrorMessage?) -> ()) {
        let realm = try! Realm()
        if let object = realm.object(ofType: realmObject.self, forPrimaryKey: targetModel.name) {
            for choiceExercise in object.choiceExercises {
                if let subObject = realm.object(ofType: RealmObjectRoutineExerciseModel.self, forPrimaryKey: choiceExercise.value(forKey: Util.omiRoutineExercise(value: .name))) {
                    try! realm.write {
                        realm.delete(subObject)
                    }
                }
            }
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

class RealmObjectRoutine: Object {
    enum VariableName: String {
        case name, choiceExercises
    }
    @objc var name: String = ""
    dynamic var choiceExercises: List<RealmObjectRoutineExerciseModel> = List<RealmObjectRoutineExerciseModel>()
    override class func primaryKey() -> String? {
        return "name"
    }
    func fromModel(model: RoutineModel)->RealmObjectRoutine {
        self.name = model.name
        for choiceExercise in model.choiceExercises {
            let temp = RealmObjectRoutineExerciseModel().fromModel(model: choiceExercise)
            self.choiceExercises.append(temp)
        }
        return self
    }
}

struct RoutineExerciseModel: Model {
    typealias realmObject = RealmObjectRoutineExerciseModel
    typealias structObject = RoutineExerciseModel

    var name: String = ""
    var exercise: String = ""
    var restTime: Int = 0
    var setCount: Int = 0

    mutating func fromRealmObject(object: realmObject) -> structObject {
        guard let name =  object.value(forKey: Util.omiRoutineExercise(value: .name)) as? String,
              let exercise =  object.value(forKey: Util.omiRoutineExercise(value: .exercise)) as? String,
              let restTime =  object.value(forKey: Util.omiRoutineExercise(value: .restTime)) as? Int,
              let setCount =  object.value(forKey: Util.omiRoutineExercise(value: .setCount)) as? Int else {return structObject()}
                
        self.name = name
        self.exercise = exercise
        self.restTime = restTime
        self.setCount = setCount
        return self
    }
    mutating func fromExercise(exercise: ExerciseModel) -> structObject{
        self.exercise = exercise.name
        return self
    }
}
class RealmObjectRoutineExerciseModel: Object {
    enum VariableName: String {
        case name, exercise, restTime, setCount
    }
    @objc var name: String = ""
    @objc var exercise: String = ""
    @objc var restTime: Int = 0
    @objc var setCount: Int = 0
    override class func primaryKey() -> String? {
        return "name"
    }
    func fromModel(model: RoutineExerciseModel)->RealmObjectRoutineExerciseModel {
        self.name = model.name
        self.exercise = model.exercise
        self.restTime = model.restTime
        self.setCount = model.setCount

        return self
    }
}
