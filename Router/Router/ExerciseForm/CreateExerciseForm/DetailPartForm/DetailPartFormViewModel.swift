//
//  DetailPartViewModel.swift
//  Router
//
//  Created by KimWooJin on 2022/12/30.
//

import Foundation

class DetailPartFormViewModel: ObservableObject {
    let model = DetailPartFormModel()
    
    @Published var isAlert: Bool = false
    @Published var alertMessage: String = ""
    
    @Published var detailPartsArray: [DetailPartFormStruct] = []
    ///    상위의 뷰에서 사용자의 부위가 변경되거나 세부부위가 추가될 때 실행되는 함수 입니다. 해당 부위의 세부부위를 가져옵니다.
    func renewSelectPart(part: BodyPart) -> [DetailPartFormStruct] {
        var resultArray: [DetailPartFormStruct] = []
        do {
            resultArray = try model.readObjects(array: self.detailPartsArray)
        }
        catch {
            CommonFunction.componentDetailprint()
            print(error)
        }
        return resultArray.filter({$0.affiliatedPart == part})
    }
    ///    세부 운동 생성 버튼 클릭 시 해당 요소를 추가한 값으로 배열을 업데이트합니다.
    func createButtonAction(part: BodyPart, name: String) {
        do {
            guard !detailPartsArray.filter({$0.affiliatedPart == part}).contains(where: {$0.name == name}) else {
                self.isAlert = true
                self.alertMessage = "이미 생성되어있는 값 입니다."
                return
            }
            //    현재 사용자가 클릭한 part에 따라 값을 저장합니다.
            try model.saveObject(value: .init(affiliatedPart: part, name: name))
        }
        catch {
            CommonFunction.componentDetailprint()
            print(error)
        }
    }
    /// 세부 운동을 오래 클릭 했을 시 삭제하기 위한 함수입니다.
    func detailLongTap(target: DetailPartFormStruct) {
        do {
            try self.model.deleteObject(value: target)
        }
        catch {
            CommonFunction.componentDetailprint()
            print(error)
        }
    }
}
