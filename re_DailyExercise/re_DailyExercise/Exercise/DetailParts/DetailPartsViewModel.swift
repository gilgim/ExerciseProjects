//
//  DetailPartsViewModel.swift
//  re_DailyExercise
//
//  Created by KimWooJin on 2022/09/23.
//

import Foundation

class DetailPartsViewModel: ObservableObject{
    @Published var model: DetailModel = .init()
    @Published var detailParts: [String] = []
    @Published var tempDetailParts: [String] = []
    var errorMessage: String = ""
    func setPart(part: String) {
        self.model.name = part
    }
    func creatDetail() {
        self.model.addRealm(targetModel: self.model) { error in
            switch error {
            case.realmIdentiferError:
                errorMessage = "부위가 선택되지않아 저장될 수 없습니다."
            case.realmAddFail:
                errorMessage = "부위가 이미 있어 저장될 수 없습니다."
            default:
                break
            }
        }
    }
    func readDetail() -> [String] {
        var result: [String] = []
        let details = self.model.readRealm(keyName: self.model.name) { error in
            if error != nil {
                print("\(String(describing: error?.rawValue))")
            }
        }
        for detail in details {
            if detail.name == self.model.name {
                result =  detail.detailParts
                break
            }
        }
        return result
    }
    func updateDetail() {
        self.model.updateRealm(targetModel: self.model) { error in
            
        }
    }
    func deleteDetail() {
        
    }
    func updateDetailView() {
        if model.name != "" {
            self.detailParts += readDetail()
            self.detailParts = Array(Set(self.detailParts)).sorted()
        }
        else {
            self.detailParts = tempDetailParts
        }
    }
}
