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
        self.model.addRealm(targetModel: DetailModel()) { error in
            switch error {
			case.realmAlreadyExist:
                errorMessage = "이미 값이 생성되어있습니다. 생성하지 않습니다."
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
		self.model.detailParts = self.detailParts
        self.model.updateRealm(targetModel: self.model) { error in
			if let error {
				_ = Util.omiErr(value: error)
				print("asdf")
			}
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
