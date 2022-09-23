//
//  DetailPartsModel.swift
//  re_DailyExercise
//
//  Created by KimWooJin on 2022/09/23.
//

import Foundation
import RealmSwift

//    MARK: -각 부위별 세부 부위 Realm
struct DetailModel: Model {
    typealias realmObject = RealmObjectDetail
    typealias structObject = DetailModel
    var name: String
    var detailParts: [String]
    var realm = try! Realm()
    init(name: String = "", detailParts: [String] = []) {
        self.name = name
        self.detailParts = detailParts
    }
    
    mutating func fromRealmObject(object: realmObject)->structObject {
        guard let name = object.value(forKey: Util.omiDetailParts(value: .name)) as? String
        else {print("Not find Value");return structObject()}
        
        self.name = name
        self.detailParts = Array(object.detailParts)
        return self
    }
}
//  컨셉 : 앱 실행 시 모든 부위에 대해서 빈 배열이라도 저장되고 항목에 값이 추가될 땐 업데이트되는 방향으로 간다.
extension DetailModel: RealmCRUD {
    //  앱 실행 시 빈 배열이라도 무조건 저장시킨다
    func addRealm(targetModel: DetailModel, notify: (ErrorMessage?) -> ()) {
        let object = RealmObjectDetail().fromModel(model: targetModel)
        if realm.object(ofType: RealmObjectDetail.self, forPrimaryKey: object.name) == nil {
            if targetModel.name != "" {
                try! realm.write {
                    realm.add(object)
                    notify(nil)
                }
            }
            else {
                notify(.realmIdentiferError)
            }
        }
        else {
            notify(.realmAddFail)
        }
    }
    
    mutating func readRealm(keyName: String?, notify: (ErrorMessage?) -> ()) -> [DetailModel] {
        var objects: [structObject] = []
        guard let keyName else {return []}
        try! realm.write {
            if keyName != "" {
                if let object = realm.object(ofType: realmObject.self, forPrimaryKey: keyName) {
                    objects.append(self.fromRealmObject(object: object))
                    notify(nil)
                }
            }
        }
        return objects
    }
    
    func updateRealm(targetModel: DetailModel, notify: (ErrorMessage?) -> ()) {
        try! realm.write {
            let object = realm.object(ofType: realmObject.self, forPrimaryKey: targetModel.name)
            if let object {
                let temp = Array(Set(Array(object.detailParts)+targetModel.detailParts))
                object.detailParts = List<String>()
                object.detailParts.append(objectsIn: temp)
                notify(nil)
            }
            else {
                notify(.realmUpdateError)
            }
        }
    }
    
    func deleteRealm(targetModel: DetailModel, notify: (ErrorMessage?) -> ()) {
        notify(.notUsingFunction)
    }
}
class RealmObjectDetail: Object {
    enum VariableName: String {
        case name, detailParts
    }
    @objc var name: String = ""
    dynamic var detailParts: List<String> = List<String>()
    
    func fromModel(model: DetailModel)->RealmObjectDetail {
        self.name = model.name
        self.detailParts.append(objectsIn: model.detailParts)
        
        return self
    }
    
    override class func primaryKey() -> String? {
        return "name"
    }
}

