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
	
    @State var part: [BodyPart] = []
	///	When user select part, this variable is used
	@State var currentPart: BodyPart?
	
	@State var detailPart: [String] = []
	///	When user create detail, this variable is used
	@State var currentDetailPart: String = ""
	
    @State var equipment: [Equipment] = []
    
    var body: some View {
        VStack {
            //  MARK:  -Name TextField
            //  FIXME: 여기 문법 이상함
            //  when focuse off textfield, result is false
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
                ForEach(bodyArray, id: \.rawValue) { component in
                    //  Body Part Action
                    Button(component.rawValue) {
						self.currentPart = component
						var isContain = false
						for index in part {
							if index == component {
								isContain = true
								break
							}
						}
						if !isContain {self.part.append(component)}
						else {self.part=self.part.filter({$0 != component})}
                        //  Calling up detail pard about affiliated part.
                        Task {
                            //  MARK: 여기를 동기처리 하지 않으면 데이터 갱신 보다 뷰 갱신이 빨라 에러가 발생한다.
                            do {
                                self.detailArray = try await detailVM.affiliatedPartButtonAction(part: component)
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
                    ForEach(detailArray, id: \.self) { component in
                        //  Detail Body Part Action
                        Button(component) {
							var isContain = false
							self.currentDetailPart = component
							for index in detailPart {
								if index == component {
									isContain = true
									break
								}
							}
							if !isContain {self.detailPart.append(component)}
							else {self.detailPart=self.detailPart.filter({$0 != component})}
                        }
                    }
                    if !(currentPart == .aerobic) {
                        Button {
                            self.isInputView = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            HStack {
                ForEach(equipmentArray, id: \.rawValue) { component in
                    //  Equipment Action
                    Button(component.rawValue) {
						var isContain = false
						self.equipment.append(component)
						for index in equipment {
							if index == component {
								isContain = true
								break
							}
						}
						if !isContain {self.equipment.append(component)}
						else {self.equipment=self.equipment.filter({$0 != component})}
                    }
                }
            }
			Button("확인") {
				print(part)
				print(detailPart)
				print(equipment)
			}
        }
        
        //  ===== Alert creating view that is used making detail part. =====
        .alert("세부부위 생성", isPresented: $isInputView) {
            TextField("부위명",text: $currentDetailPart)
            //  Substantive Function
            Button("생성") {
                Task {
                    do {
                        await detailVM.plusOkButtonAction(part: currentPart, append: currentDetailPart)
                        self.detailArray = try await detailVM.affiliatedPartButtonAction(part: currentPart)
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
