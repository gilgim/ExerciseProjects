//
//  ExerciseFormModel.swift
//  Router
//
//  Created by KimWooJin on 2022/12/18.
//

import Foundation
import RealmSwift
import SwiftUI
struct ExerciseFormModel: Model {
    typealias structObject = ExerciseFormStruct
    
    /// Realm 파일의 호출 및 변화를 확인하기 위해 바로 할당하지 않고 print를 통해 보수를 쉽게하고자 했습니다.
    let realm: Realm? = {
        CommonFunction.printTitle(title: "Inquire Realm", isDetail: true)
        let realm = try? Realm()
        guard let realm else {print("Realm data is not right value.");return nil}
        print("Success inquired realm data.")
        return realm
    }()
    
    func saveObject(value: ExerciseFormStruct) throws {
        guard let realm else {
            CommonFunction.componentDetailprint()
            throw ErrorType.RealmDataLookUpError
        }
        //  해당 운동명을 가진 운동이 이미 존재하는지에 대한 guard 문 입니다.
        let key = value.name
        guard realm.object(ofType: ExerciseFormRealm.self, forPrimaryKey: key) == nil else{print("Aleady exist value");return}
        //  구조체를 Realm 객체로 변환하기 위한 guard 문 입니다.
        guard let object = value.structToRealm() else {
            CommonFunction.componentDetailprint()
            throw ErrorType.StructValueConvertError
        }
        //  Realm에 해당 객체를 저장합니다.
        try realm.write({
            realm.add(object)
        })
    }
    
    func readObjects(array: [ExerciseFormStruct] = []) throws -> [ExerciseFormStruct] {
        guard let realm else {
            CommonFunction.componentDetailprint()
            throw ErrorType.RealmDataLookUpError
        }
        var storeArray = array
        if storeArray.isEmpty {
            return try realm.objects(ExerciseFormRealm.self).map({ realmObject in
                //  Realm 오브젝트를 구조체로 변경하기 위한 guard 문 입니다.
                guard let exercise = realmObject.realmToStruct() else {
                    CommonFunction.componentDetailprint()
                    throw ErrorType.RealmValueConvertError
                }
                return exercise
            })
        }
        //  배열이 비어있지 않다면 변화된 것에 대한 json decode만 실행하기 위한 if문 입니다.
        else {
            storeArray += try realm.objects(ExerciseFormRealm.self).filter({ realmObject in
                return !storeArray.contains(where: {$0.name == realmObject.keyValue})}).map({ realmObject in
                    //  Realm 오브젝트를 구조체로 변경하기 위한 guard 문 입니다.
                        guard let exercise = realmObject.realmToStruct() else {
                            CommonFunction.componentDetailprint()
                            throw ErrorType.RealmValueConvertError
                        }
                        return exercise
                })
            return storeArray
        }
    }
    
    func readObject(key: String) throws -> ExerciseFormStruct? {
        guard let realm else {
            CommonFunction.componentDetailprint()
            throw ErrorType.RealmDataLookUpError
        }
        return realm.object(ofType: ExerciseFormRealm.self, forPrimaryKey: key)?.realmToStruct()
    }
    
    func updateObject(value: ExerciseFormStruct) throws {
        
    }
    
    func deleteObject(value: ExerciseFormStruct) throws {
        
    }
    
   
}

struct ExerciseFormStruct: Codable, Equatable {
    /**
     주로 SF Symbol name 으로 저장될 String 입니다.
     
     사용자가 저장한 사진의 이름이 될 수도 있습니다.
     */
    var imageName: String
    
    /// 저장된 Hex String 값 입니다.
    var imageColorName: String
    
    /**
     사용자가 지정한 운동 명칭으로 중복 값은 허용하지 않습니다.
     
     Exercise 데이터는 name이 키 값이 되어 유일값을 가집니다. 즉 nil을 허용하지 않습니다.
     */
    var name: String
    
    /// 사용자가 운동 시 참고할 메모 입니다. nil 값을 허용합니다.
    var explain: String?
    
    /**
     사용자가 운동 생성 시 할당하는 운동하는 부위 입니다.
     
     같은 운동이라도 부위를 다르게 설정할 수 있게 Array로 작성하였습니다.
     대근육 마다 세부부위를 가집니다.
     */
    var parts: [BodyPart]
    
    /**
     대근육을 제외한 세부 근육 부위는 설정 값이 유저마다 달라 유저가 저장하는 값을 사용합니다.
     대근육 마다 세부부위를 가집니다.
     */
    var detailParts: [DetailPartFormStruct]?
    
    /// 유저마다 사용하는 도구가 다르기 때문에 배열로 작성해 커스텀이 가능합니다.
    var equipments: [Equipment]
    
    /**
     Json으로 인코딩하여 저장할려고 할 때 사용되는 Initailize 입니다.
     -  parameters:
        -   imageName: 아이콘의 문양으로 사용되는 이미지 이름입니다. 주로 SF symbol 이름이 저장됩니다. 초기값은 덤벨 이미지 입니다.
        -   imageColorName: 아이콘의 색상의 HexCode 입니다. 초기값은 CustomColor의 회색입니다.
        -   explain: 운동을 설명하는 String 값으로 nil를 허용합니다.
        -   parts: BodyPart 중 여러 값을 가지고 있는 배열입니다.
        -   detailParts: 대근육에 세부부위 배열을 뜻하며 외래키 값은 parts의 요소입니다.
        -   equipments: 사용자가 선택한 장비입니다. Equipment의 값 중 여러 값을 포합하고 있습니다.
     */
    init(imageName: String? = nil, imageColorName: String? = nil,
         name: String, explain: String? = nil, parts: [BodyPart], detailParts: [DetailPartFormStruct]? = nil, equipments: [Equipment]) {
        self.imageName = imageName ?? "dumbbell.fill"
        self.imageColorName = imageColorName ?? CustomColor.gray.colorHex
        self.name = name
        self.explain = explain
        self.parts = parts
        self.detailParts = detailParts
        self.equipments = equipments
    }
    //  ExerciseFormStruct를 비교할 수 있게 만들어주는 함수이며 이름으로 서로를 구분합니다.
    static func == (lhs: ExerciseFormStruct, rhs: ExerciseFormStruct) -> Bool {
        return lhs.name == rhs.name
    }
}
extension ExerciseFormStruct: StructObject {
    typealias realmObject = ExerciseFormRealm
    func structToRealm() -> ExerciseFormRealm? {
        let realmObject = ExerciseFormRealm()
        realmObject.keyValue = self.name
        guard let json = CommonFunction.makeJsonString(jsonType: self) else {return nil}
        realmObject.jsonString = json
        return realmObject
    }
}

class ExerciseFormRealm: Object {
    @Persisted(primaryKey: true) var keyValue: String
    @Persisted var jsonString: String
}
extension ExerciseFormRealm: RealmObject {
    typealias structObject = ExerciseFormStruct
    func realmToStruct() -> ExerciseFormStruct? {
        return CommonFunction.decodingJson(jsonString: self.jsonString, type: ExerciseFormStruct.self)
    }
}
