//
//  ExerciseModel.swift
//  RecordingExcerCise
//
//  Created by KimWooJin on 2022/06/20.
//
/*
 뷰들을 Object 타입으로 만든 것이 아닌 Struct 타입으로 만들었기 떄문에 Object를 Struct 로 변환해서 뷰에 넣어줘야하고
 또한 Struct를 Object로 변경해서 저장 할 수 있게 Model를 짜야한다.
 */
import Foundation
import RealmSwift

//  카테고리 뷰에 들어갈
struct ExerciseModel : Hashable {
    //  운동명
    var name : String?
    //  동작설명
    var explain : String?
    //  운동부위
    var bodyPart : [String]?
    //  세부부위명칭
    var detailPart : [String]?
    //  장비
    var equipment : [String]?
    var link : String?
    var linkTitle : String?
    
    var setCount = 0
    var count = 0
    var RPE : Double = 0
    
    func isNotNil(isPrint:Bool = false)->Bool{
        guard name != nil, explain != nil, bodyPart != nil, detailPart != nil, equipment != nil, link != nil, linkTitle != nil
        else{
            if isPrint {
                print("====== VALUE ======")
                print("name: \(String(describing: name))")
                print("explain: \(String(describing: explain))")
                print("bodyPart: \(String(describing: bodyPart))")
                print("detailPart: \(String(describing: detailPart))")
                print("equipment: \(String(describing: equipment))")
                print("linkTitle: \(String(describing: linkTitle))")
                print("link: \(String(describing: link))")
            }
            return false
        }
        return true
    }
}

/**
 Realm 운동 오브젝트
 */
final class ExerciseObject : Object{
    //  운동명
    @objc dynamic var name : String = ""
    //  동작설명
    @objc dynamic var explain : String = ""
    //  운동부위
    dynamic var bodyPart = List<String>()
    //  세부부위명칭
    dynamic var detailPart = List<String>()
    //  장비
    dynamic var equipment = List<String>()
    @objc dynamic var link : String = ""
    @objc dynamic var linkTitle : String = ""
    
    override static func primaryKey() -> String? {
        return "name"
    }
}

extension ExerciseModel : Persistable {
    public init(managedObject: ExerciseObject) {
        name = managedObject.name
        explain = managedObject.explain
        bodyPart = managedObject.bodyPart.reversed()
        detailPart = managedObject.detailPart.reversed()
        equipment = managedObject.equipment.reversed()
        link = managedObject.link
        linkTitle = managedObject.linkTitle
    }
    public func managedObject() -> ExerciseObject {
        let exercise = ExerciseObject()
        let nilString = "값이 없습니다."
        
        exercise.name = name ?? nilString
        exercise.explain = explain ?? nilString
        exercise.bodyPart.append(objectsIn: bodyPart ?? [nilString])
        exercise.detailPart.append(objectsIn: detailPart ?? [nilString])
        exercise.equipment.append(objectsIn: equipment ?? [nilString])
        exercise.link = link ?? nilString
        exercise.linkTitle = linkTitle ?? nilString
        
        return exercise
    }
}
