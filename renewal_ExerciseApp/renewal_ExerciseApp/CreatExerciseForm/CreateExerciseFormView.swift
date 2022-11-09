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
                    Button(part.rawValue) {
                        self.part = part
                        //  Calling up detail pard about affiliated part.
                        do {
                            self.detailArray = try detailVM.affiliatedPartButtonAction(part: part)
                        }
                        catch {
                            catchMessage(error)
                        }
                    }
                }
            }
            //  MARK:  -Select detail body part
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(detailArray, id: \.self) { part in
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
        }
        
        //  ===== Alert creating view that is used making detail part. =====
        .alert("세부부위 생성", isPresented: $isInputView) {
            TextField("부위명",text: $detailPart)
            //  Substantive Function
            Button("생성") {
                Task {
                    do {
                        await detailVM.plusOkButtonAction(part: part, append: detailPart)
                        self.detailArray = try detailVM.affiliatedPartButtonAction(part: part)
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
