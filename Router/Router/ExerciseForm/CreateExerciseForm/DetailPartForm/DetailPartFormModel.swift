//
//  DetailPartFormModel.swift
//  Router
//
//  Created by KimWooJin on 2022/12/18.
//

import Foundation
import RealmSwift
/**
 대 근육에 속해있는 세부 부위에 대한 구조체입니다.
 
 이름은 고유값으로 사용되고, 대근육 변수 가지고 있어 대근육 조회 시 해당 변수가 조회 근육과 같다면 호출됩니다.
 */
struct DetailPartFormStruct: Codable {
    /// 세부부위가 할당된 대근육 입니다.
    var affiliatedPart: BodyPart
    
    /// 대근육에 포함된 세부 부위의 이름이며, 유일 값이기 때문에 고유합니다.
	var name: [String]
}
extension DetailPartFormStruct: StructObject {
    typealias realmObject = DetailPartFormRealm
    
    func structToRealm() -> DetailPartFormRealm? {
        guard let jsonString = CommonFunction.makeJsonString(jsonType: self) else {return nil}
        var object = DetailPartFormRealm()
        object.keyValue = affiliatedPart.rawValue
        object.jsonString = jsonString
        return object
    }
}

/// DetailPartFormStruct와 매핑되는 Realm 데이터 입니다.
class DetailPartFormRealm: Object {
    @Persisted(primaryKey: true) var keyValue: String
    @Persisted var jsonString: String
}
extension DetailPartFormRealm: RealmObject {
    typealias structObject = DetailPartFormStruct
    
    func realmToStruct() -> DetailPartFormStruct? {
        return CommonFunction.decodingJson(jsonString: self.jsonString, type: DetailPartFormStruct.self)
    }
}
