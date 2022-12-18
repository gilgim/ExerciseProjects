//
//  DetailPartFormModel.swift
//  Router
//
//  Created by KimWooJin on 2022/12/18.
//

import Foundation

///	- Korean : 운동 부위가 포함하는 세부부위로 사용자 마다 칭하는 명칭과 느낌이 다르기 때문에 커스터마이징 가능하게 한다.
///	- English :
struct DetailPartFormStruct: Codable {
	///	- Korean : 세부부위 이름은 중복 값을 허용하지 않는다.
	///	- English :
	var name: String
	///	- Korean : 세부부위가 포함된 큰 부위를 칭한다.
	///	- English :
	var affiliatedPart: BodyPart
}
