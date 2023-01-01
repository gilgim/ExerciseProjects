//
//  DetailPartViewModel.swift
//  Router
//
//  Created by KimWooJin on 2022/12/30.
//

import Foundation

class DetailPartFormViewModel: ObservableObject {
	let model = DetailPartFormModel()
	@Published var detailPartsArray: [String] = []
	///	상위의 뷰에서 사용자의 부위 선택이 변경 될 때 실행되는 함수입니다. 해당 부위의 세부부위를 가져옵니다.
	func renewSelectPart(part: BodyPart) {
		do {
			guard let keyDetailPart = try model.readObject(key: part.rawValue)?.name else {return}
			self.detailPartsArray = keyDetailPart
		}
		catch {
			CommonFunction.componentDetailprint()
			print(error)
		}
	}
	///	세부 운동 생성 버튼 클릭 시 해당 요소를 추가한 값으로 배열을 업데이트합니다.
	func createButtonAction(part: BodyPart) {
		do {
			//	현재 사용자가 클릭한 part에 따라 값을 저장합니다.
			try model.updateObject(value: .init(affiliatedPart: part, name: detailPartsArray))
		}
		catch {
			CommonFunction.componentDetailprint()
			print(error)
		}
	}
}
