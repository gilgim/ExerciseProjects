//
//  DoExerciseModel.swift
//  re_DailyExercise
//
//  Created by KimWooJin on 2022/09/16.
//

import Foundation
import RealmSwift
struct DoExerciseModel: Model {
    typealias realmObject = RealmObjectDoExercise
    typealias structObject = DoExerciseModel
    
    let realm = try! Realm()
    var name: String
    var doExercises: [DoExerciseDetail]
    var totalTime: Int
    var startTime: Int
    init(name: String = "", doExercises: [DoExerciseDetail] = [], totalTime: Int = 0, startTime: Int = 0) {
        self.name = name
        self.doExercises = doExercises
        self.totalTime = totalTime
        self.startTime = startTime
    }
    mutating func fromRealmObject(object: realmObject) -> structObject {
        guard let name = object.value(forKey: Util.omiDoExerciseDetail(value: .name)) as? String,
              let doExercises = object.value(forKey: Util.omiDoExercise(value: .doExercises)) as? List<RealmObjectDoExerciseDetail>,
              let totalTime = object.value(forKey: Util.omiDoExercise(value: .totalTime)) as? Int,
              let startTime = object.value(forKey: Util.omiDoExercise(value: .startTime)) as? Int else {return structObject()}
        
        self.name = name
        self.totalTime = totalTime
        self.startTime = startTime
        
        for doExercise in doExercises {
            var temp = DoExerciseDetail()
            let tempValue = temp.fromRealmObject(object: doExercise)
            self.doExercises.append(tempValue)
        }
        return self
    }
}
extension DoExerciseModel: RealmCRUD {
    func addRealm(targetModel: DoExerciseModel, notify: (ErrorMessage?) -> ()) {
        let saveObject = realmObject().fromModel(model: targetModel)
        do {
            try realm.write {
                realm.add(saveObject)
                notify(nil)
            }
        }catch {
            notify(.realmAddFail)
        }
    }

    //  R
    mutating func readRealm(keyName: String? = nil, notify: (ErrorMessage?) -> ()) -> [structObject] {
        var objects: [structObject] = []
        return objects
    }
    //  U
    func updateRealm(targetModel: DoExerciseModel, notify: (ErrorMessage?) -> ()) {
        
    }
    //  D
    func deleteRealm(targetModel: DoExerciseModel, notify: (ErrorMessage?) -> ()) {
    }
}
class RealmObjectDoExercise: Object {
    enum VariableName: String {
        case name, doExercises, totalTime, startTime
    }
    @objc var name: String = ""
    @objc var totalTime: Int = 0
    @objc var startTime: Int = 0
    dynamic var doExercises: List<RealmObjectDoExerciseDetail> = List<RealmObjectDoExerciseDetail>()
    func fromModel(model: DoExerciseModel)->RealmObjectDoExercise {
        self.name = model.name
        for doExercise in model.doExercises {
            let temp = RealmObjectDoExerciseDetail().fromModel(model: doExercise)
            self.doExercises.append(temp)
        }
        return self
    }
}
//  MARK: - 루틴에 포함된 운동
struct DoExerciseDetail: Model {
    typealias realmObject = RealmObjectDoExerciseDetail
    typealias structObject = DoExerciseDetail
    
    var name: String
    var setDetails: [DoExerciseSetDetail]
    init(name: String = "" ,setDetails: [DoExerciseSetDetail] = []) {
        self.name = name
        self.setDetails = setDetails
    }
    mutating func fromRealmObject(object: realmObject) -> structObject {
        guard let name = object.value(forKey: Util.omiDoExerciseDetail(value: .name)) as? String,
              let setDetails = object.value(forKey: Util.omiDoExerciseDetail(value: .setDetails)) as? List<RealmObjectDoExerciseSetDetail> else {return structObject()}
        self.name = name
        for setDetail in setDetails {
            var temp = DoExerciseSetDetail()
            let tempValue = temp.fromRealmObject(object: setDetail)
            self.setDetails.append(tempValue)
        }
        return self
    }
}
class RealmObjectDoExerciseDetail: Object {
    enum VariableName: String {
        case name, setDetails
    }
    @objc var name: String = ""
    dynamic var setDetails: List<RealmObjectDoExerciseSetDetail> = List<RealmObjectDoExerciseSetDetail>()
    override class func primaryKey() -> String? {
        return "name"
    }
    func fromModel(model: DoExerciseDetail)->RealmObjectDoExerciseDetail {
        self.name = model.name
        for setDetail in model.setDetails {
            let temp = RealmObjectDoExerciseSetDetail().fromModel(model: setDetail)
            self.setDetails.append(temp)
        }
        return self
    }
}

//  MARK: - 운동에 포함된 세트
struct DoExerciseSetDetail: Model {
    typealias realmObject = RealmObjectDoExerciseSetDetail
    typealias structObject = DoExerciseSetDetail
    
    var name: String = ""
    var set: Int = 0
    var restTime: Int = 0
    var weight : Int = 0
    mutating func fromRealmObject(object: realmObject) -> structObject {
        guard let name =  object.value(forKey: Util.omiDoExerciseSetDetail(value: .name)) as? String,
              let set =  object.value(forKey: Util.omiDoExerciseSetDetail(value: .set)) as? Int,
              let restTime =  object.value(forKey: Util.omiDoExerciseSetDetail(value: .restTime)) as? Int,
              let weight =  object.value(forKey: Util.omiDoExerciseSetDetail(value: .weight)) as? Int else {return structObject()}
                
        self.name = name
        self.set = set
        self.restTime = restTime
        self.weight = weight
        return self
    }
}

class RealmObjectDoExerciseSetDetail: Object {
    enum VariableName: String {
        case name, set, restTime, weight
    }
    @objc var name: String = ""
    @objc var set: Int = 0
    @objc var restTime: Int = 0
    @objc var weight: Int = 0
    override class func primaryKey() -> String? {
        return "name"
    }
    func fromModel(model: DoExerciseSetDetail)->RealmObjectDoExerciseSetDetail {
        self.name = model.name
        self.set = model.set
        self.restTime = model.restTime
        self.weight = model.weight

        return self
    }
}
