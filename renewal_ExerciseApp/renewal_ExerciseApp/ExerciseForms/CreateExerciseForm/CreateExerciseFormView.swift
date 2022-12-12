//
//  CreateExerciseFormView.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/10/24.
//

import SwiftUI
import PhotosUI
import Foundation

struct CreateExerciseFormView: View {
    //  ================================ < About View Variable > ================================
    @Environment(\.presentationMode) var mode
    
    var bodyArray: [BodyPart] = BodyPart.allCases
    var equipmentArray: [Equipment] = Equipment.allCases
    @State var detailArray: [DetailPartStruct] = []
    
    @State var isInputView: Bool = false
    @State var isLibrary: Bool = false
    @State var isModify: Bool = false
    @State var dateSetClosure: (()->())?
    //  ================================ < About ViewModel > ================================
    @StateObject var createFormVM = CreateExerciseViewModel()
    @StateObject var detailVM = CreateDetailPartViewModel()
    //  ================================ < Input Variable > ================================
    /// If user need to modify exercise form, input value allocate realm data when view appear
    @State var image: UIImage?
    @State var isImageDelete: Bool = false
    
    @State var nameText: String = ""
    @State var explainText: String = ""
    @State var linkText: String = ""
    @State var part: [BodyPart] = []
	///	When user select part, this variable is used
	@State var currentPart: BodyPart?
	@State var detailPart: [DetailPartStruct] = []
	///	When user create detail, this variable is used
	@State var currentDetailPart: String = ""
    @State var equipment: [Equipment] = []
    
    var body: some View {
        VStack {
            //  MARK: PhotoPicker
            if createFormVM.imageData == nil {
                Button {
                    self.isLibrary = true
                }label: {
                    Rectangle()
                        .foregroundColor(.gray)
                        .overlay {Image(systemName: "plus").foregroundColor(.black)}
                }
            }
            else {
                if let imageData = createFormVM.imageData, let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage).resizable()
                        .onTapGesture {
                            self.isImageDelete = true
                        }
                }
            }
            //  MARK:  -Name TextField
            //  When user focuse on textfield, result is true
            TextField("Exercise name", text: $nameText) { isEdit in
            }
            //  MARK:  -Explain TextField
            TextField("Exercise explain", text: $explainText) { isEdit in
            }
            //  MARK:  -Link TextField
            TextField("Exercise link", text: $linkText) { isEdit in
            }
            //  MARK:  -Select body part
            HStack {
                ForEach(bodyArray, id: \.rawValue) { component in
                    //  Body Part Action
                    Button(component.rawValue) {
                        //  클릭한 버튼이 이전에 클릭한 버튼과 같을 때
                        //  When the user clicked button is samed previous button
                        if self.currentPart == component {
                            self.part = self.part.filter({$0 != component})
                            self.detailPart = self.detailPart.filter({$0.affiliatedPart != component})
                        }
                        else {
                            var isContain = false
                            for index in part {
                                if index == component {
                                    isContain = true
                                    break
                                }
                            }
                            if !isContain {self.part.append(component)}
                            else {
                                self.part = self.part.filter({$0 != component})
                                let temp = self.detailPart
                                self.detailPart = self.detailPart.filter({$0.affiliatedPart != component})
                                self.part.append(component)
                                self.detailPart = temp
                            }
                        }
                        self.currentPart = component
                        //  Calling up detail pard about affiliated part.
                        do {
                            self.detailArray = try  detailVM.affiliatedPartButtonAction(part: component)
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
                    ForEach(detailArray, id: \.name) { component in
                        //  Detail Body Part Action
                        Button(component.name ?? "error") {
							var isContain = false
                            guard let detailPartName = component.name else {return}
                            self.currentDetailPart = detailPartName
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
                    if !(currentPart == .Aerobic) {
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
        }
        //  ===== When data is changed on the moment =====
        .onChange(of: createFormVM.isCreate, perform: { newValue in
            if newValue {
                self.mode.wrappedValue.dismiss()
            }
        })
        //  ===== Navigation Itemp =====
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("생성") {
                    Task {
                        var object = ExerciseFormStruct(name: self.nameText, explain: self.explainText, link: self.linkText, part: self.part, detailPart: self.detailPart, equipment: self.equipment)
                        if let imageData = createFormVM.imageData, UIImage(data: imageData) != nil {
                            object.sfSymbolName = IDKeyword.UiImage.rawValue
                        }
                        self.createFormVM.createButtonAction(exerciseObject:object)
                    }
                }
            }
        }
        //  ===== About Sheet =====
        .sheet(isPresented: $isLibrary, content: {
            CustomPHPickerView(selectImage: $image, imageData: $createFormVM.imageData, closure: $dateSetClosure)
        })
        //  ===== Notice Error about user input =====
        //  It is error pop up  about creating detail part
        .alert("상세부위 오류", isPresented: $detailVM.isErrorAlert) {
            Button("확인", role: .cancel) {}
        }message: {
            Text(detailVM.errorText ?? "알 수 없음")
        }
        //  It is error pop up  about creating form
        .alert("생성 오류", isPresented: $createFormVM.isErrorAlert) {
            Button("확인", role: .cancel) {}
        }message: {
            Text(createFormVM.errorText ?? "알 수 없음")
        }
        //  It is delete to image
        .alert("삭제하기", isPresented: $isImageDelete) {
            Button("확인", role: .destructive) {
                createFormVM.imageData = nil
            }
            Button("취소", role: .cancel) {}
        }message: {
            Text("해당 이미지를 삭제하시겠습니까?")
        }
        //  Alert creating view that is used making detail part.
        .alert("세부부위 생성", isPresented: $isInputView) {
            TextField("부위명",text: $currentDetailPart)
            //  Substantive Function
            Button("생성") {
                do {
                    self.detailVM.plusOkButtonAction(part: currentPart, append: currentDetailPart)
                    self.detailArray = try detailVM.affiliatedPartButtonAction(part: currentPart)
                }
                catch {
                    catchMessage(error)
                }
                //  When create detailPart, string value should empty.
                self.currentDetailPart = ""
            }
            Button("취소", role: .cancel) {}
        }message: {
            Text("선택할 세부부위를 생성해주세요.")
        }
    }
}

struct CreateExerciseFormView_Previews: PreviewProvider {
    static var previews: some View {
        CreateExerciseFormView()
    }
}
