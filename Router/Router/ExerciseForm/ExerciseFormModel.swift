//
//  ExerciseFormModel.swift
//  Router
//
//  Created by KimWooJin on 2022/12/18.
//

import Foundation

struct ExerciseFormStruct: Codable {
	///	- Korean : 이미지는 아이콘과 사진이 사용된다. 특정 키워드로 구분한다. 이미지 파라미터 값이 변화되기 때문이다.
	///	- English :
	var imageName: String?
	///	- Korean : 운동 이름은 중복을 허용하지 않는다.
	///	- English :
	var name: String
	///	- Korean : 설명은 nil 값을 허용한다.
	///	- English :
	var exercise: String?
	///	- Korean : 운동 부위는 nil 경우 부위를 인지 할 수 없기 때문에 nil은 허용하지 않는다.
	///	- English :
	var parts: [BodyPart]
	///	- Korean : 세부 부위는 정해지지 않아도 운동을 저장할 수 있다.
	///	- English :
	var detailParts: String?
	///	- Korean : 운동 기구는 정해지지 않으면 어떠한 기구로 운동을 진행했는지 정확히 알 수 없기에 nil을 허용하지 않는다.
	///	- English :
	var equipments: [Equipment]
}
