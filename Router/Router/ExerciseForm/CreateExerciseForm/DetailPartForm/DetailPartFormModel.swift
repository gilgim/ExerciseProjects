//
//  DetailPartFormModel.swift
//  Router
//
//  Created by KimWooJin on 2022/12/18.
//

import Foundation
import RealmSwift

struct DetailPartFormModel: Model {
	typealias structObject = DetailPartFormStruct
	
	/// Realm 파일의 호출 및 변화를 확인하기 위해 바로 할당하지 않고 print를 통해 보수를 쉽게하고자 했습니다.
	let realm: Realm? = {
		CommonFunction.printTitle(title: "Inquire Realm", isDetail: true)
		let realm = try? Realm()
		guard let realm else {print("Realm data is not right value.");return nil}
		print("Success inquired realm data.")
		return realm
	}()
	
	//	맨 처음 실행, 즉 앱 설치 후 맨 처음 실행 시에만 사용됩니다.
	/**
	 Body part 배열의 모든 값을 key로 가지는  세부 운동을 생성합니다.
	 
	 -	parameters:
		-	value: 세부 운동 값으로 [] Empty 값을 기댓값으로 생각하고 있습니다.
	 */
	func saveObject(value: DetailPartFormStruct) throws {
		guard let realm else {
			CommonFunction.componentDetailprint()
			throw ErrorType.RealmDataLookUpError
		}
		guard let realmObject = value.structToRealm() else {return}
		try realm.write({
			realm.add(realmObject)
		})
	}
	
	///	모든 부위에 관한 세부부위를 가져올 수 있습니다.
	func readObjects(array: [DetailPartFormStruct]) throws -> [DetailPartFormStruct] {
		guard let realm else {
			CommonFunction.componentDetailprint()
			throw ErrorType.RealmDataLookUpError
		}
		return try realm.objects(DetailPartFormRealm.self).map({
			guard let detailPart = $0.realmToStruct() else {
				CommonFunction.componentDetailprint()
				throw ErrorType.RealmValueConvertError
			}
			return detailPart
		})
	}
	
	///	한 부위에 관한 세부부위를 가져올 수 있습니다.
	func readObject(key: String) throws -> DetailPartFormStruct? {
		guard let realm else {
			CommonFunction.componentDetailprint()
			throw ErrorType.RealmDataLookUpError
		}
		//	json 값을 받아옵니다.
		let jsonString = realm.object(ofType: DetailPartFormRealm.self, forPrimaryKey: key)?.jsonString
		//	json 값이 없는 최초 실행 시 빈 객체를 생성합니다.
		guard let jsonString else {
			guard let bodyKeyValue: BodyPart = .init(rawValue: key) else {
				throw ErrorType.NotFindEnumError(key)
			}
			for part in BodyPart.allCases {
				try self.saveObject(value: .init(affiliatedPart: part, name: []))
			}
			return .init(affiliatedPart: bodyKeyValue , name: [])
		}
		return CommonFunction.decodingJson(jsonString: jsonString, type: DetailPartFormStruct.self)
	}
	
	func updateObject(value: DetailPartFormStruct) throws {
		guard let realm else {
			CommonFunction.componentDetailprint()
			throw ErrorType.RealmDataLookUpError
		}
		//	현재 부위의 할당된 세부부위를 가져옵니다.
		guard let object = realm.object(ofType: DetailPartFormRealm.self, forPrimaryKey: value.affiliatedPart.rawValue) else {
			CommonFunction.componentDetailprint()
			throw ErrorType.RealmDataLookUpError
		}
		//	사용자가 입력한 값의 새로운 Json 값을 생성합니다.
		guard let newJsonString = CommonFunction.makeJsonString(jsonType: value) else {
			CommonFunction.componentDetailprint()
			throw ErrorType.StructValueConvertError
		}
		try realm.write({
			//	Json을 업데이트합니다.
			object.jsonString = newJsonString
		})
	}
	
	func deleteObject() throws {
	}
}
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
        let object = DetailPartFormRealm()
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
