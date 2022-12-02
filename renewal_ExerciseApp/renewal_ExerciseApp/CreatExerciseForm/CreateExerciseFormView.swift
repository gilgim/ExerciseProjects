//
//  CreateExerciseFormView.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/10/24.
//

import SwiftUI

struct CreateExerciseFormView: View {
    //  ================================ < About View Variable > ================================
    var bodyArray: [BodyPart] = BodyPart.allCases
    var equipmentArray: [Equipment] = Equipment.allCases
    @State var detailArray: [String] = []
    @State var isInputView: Bool = false
    //  ================================ < About ViewModel > ================================
    @StateObject var exerciseVM = CreateExerciseViewModel()
    @StateObject var detailVM = CreateDetailPartViewModel()
    //  ================================ < Input Variable > ================================
    @State var nameText: String = ""
    @State var explainText: String = ""
    @State var linkText: String = ""
    @State var part: BodyPart?
    @State var detailPart: String = ""
    @State var equipment: String = ""
    
    var body: some View {
        VStack {
            //  MARK:  -Name TextField
            TextField("Exercise name", text: $nameText) { isEdit in
                print(isEdit)
            }
            //  MARK:  -Explain TextField
            TextField("Exercise explain", text: $explainText) { isEdit in
                print(isEdit)
            }
            //  MARK:  -Link TextField
            TextField("Exercise link", text: $linkText) { isEdit in
                print(isEdit)
            }
            //  MARK:  -Select body part
            HStack {
                ForEach(bodyArray, id: \.rawValue) { part in
                    //  Body Part Action
                    Button(part.rawValue) {
                        self.part = part
                        //  Calling up detail pard about affiliated part.
                        Task {
                            //  MARK: 여기를 동기처리 하지 않으면 데이터 갱신 보다 뷰 갱신이 빨라 에러가 발생한다.
                            do {
                                self.detailArray = try await detailVM.affiliatedPartButtonAction(part: part)
                            }
                            catch {
                                catchMessage(error)
                            }
                        }
                    }
                }
            }
            //  FIXME: 여기 운동 세부 부위 배열로 만들기.
            //  MARK:  -Select detail body part
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(detailArray, id: \.self) { part in
                        //  Detail Body Part Action
                        Button(part) {
                            self.detailPart = part
                        }
                    }
                    if !(part == .aerobic) {
                        Button {
                            self.detailPart = ""
                            self.isInputView = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            HStack {
                ForEach(equipmentArray, id: \.rawValue) { equipment in
                    //  Equipment Action
                    Button(equipment.rawValue) {
                        self.equipment = equipment.rawValue
                    }
                }
            }
        }
        
        //  ===== Alert creating view that is used making detail part. =====
        .alert("세부부위 생성", isPresented: $isInputView) {
            TextField("부위명",text: $detailPart)
            //  Substantive Function
            Button("생성") {
                Task {
                    do {
                        await detailVM.plusOkButtonAction(part: part, append: detailPart)
                        self.detailArray = try await detailVM.affiliatedPartButtonAction(part: part)
                    }
                    catch {
                        catchMessage(error)
                    }
                }
            }
            Button("취소", role: .cancel) {}
        }message: {
            Text("선택할 세부부위를 생성해주세요.")
        }
        //  ===== Notice Error about user input =====
        .alert("에러", isPresented: $detailVM.isErrorAlert) {
            Button("확인", role: .cancel) {}
        }message: {
            Text(detailVM.errorText ?? "알 수 없음")
        }
        //  ===== Navigation Itemp =====
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("생성") {
                    ExerciseFormStruct(name: self.nameText, explain: self.explainText, link: self.linkText)
                }
            }
        }
    }
}

struct CreateExerciseFormView_Previews: PreviewProvider {
    static var previews: some View {
        CreateExerciseFormView()
    }
}
