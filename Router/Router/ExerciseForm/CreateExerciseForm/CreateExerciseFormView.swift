//
//  CreateExerciseFormView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/19.
//

import SwiftUI
struct CreateExerciseFormView: View {
    //  ===== User Inputs =====
    @State var selectColor: CustomColor?
    @State var sfIconName: String?
    @State var name: String = ""
    @State var explain: String = ""
    @State var parts: [BodyPart] = []
	@State var detailParts: DetailPartFormStruct?
    @State var equipments: [Equipment] = []
    
    //  ===== About View =====
    @State var isSelectImageAlert: Bool = false
    @State var isShowIconView: Bool = false
    @State var isShowKeyboard: Bool = false
    @State var clickPart: BodyPart?
    
    @Environment(\.dismiss) var mode
    @StateObject var createVM = CreateExerciseFormViewModel()
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    //  아이콘을 나타내는 뷰 입니다. 클릭 시 아이콘 문양을 선택할 수 있는 Action Sheet가 호출됩니다.
                    Button {
                        self.isSelectImageAlert.toggle()
                    }label: {
                        Circle()
                            .modifier(CustomCircleModifier(color: self.selectColor?.color, iconName: self.sfIconName == nil ? "plus" : self.sfIconName))
                            .frame(width: 150)
                            .padding(.vertical, 10)
                    }
                    //  사용자가 운동 이름을 입력할 수 있는 텍스트 Editor 입니다.
                    CustomTextEditor("이름", text: $name)
                        .fontWeight(.bold)
                        .modifier(BackRoundedRecModifier(cornerValue: 8))
                        .frame(height: UIScreen.main.bounds.height * 0.08)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                    
                    //  사용자가 운동 시 관련 설명을 입력할 수 있는 텍스트 Editor 입니다.
                    CustomTextEditor("설명", text: $explain, isLink: true)
                        .modifier(BackRoundedRecModifier(cornerValue: 8))
                        .frame(height: UIScreen.main.bounds.height * 0.3)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                    
                    //  운동 생성 시 해당 운동에 맞는 부위를 사용자가 직접 제작할 수 있습니다.
                    TitleView(title: "부위 선택")
                        .padding(.bottom, 5)
                    PartsGridView(stackPart: $clickPart, parts: $parts, detailPart: $detailParts)
                        .padding(.horizontal, 10)
                    
                    //  사용자가 부위 선택 시 세부부위를 저장 및 생성할 수 있습니다.
                    if let clickPart, !parts.isEmpty {
                        TitleView(title: "\(clickPart.rawValue) 세부 선택")
                        DetailPartFormView(affiliatedPart: $clickPart, superDetailPart: $detailParts)
                    }
                    
                    //  운동 생성 시 해당 운동에 맞는 기구 및 방법을 선택할 수 있습니다.
                    TitleView(title: "운동 방법")
                        .padding(.bottom, 5)
                    EquipmentsGridView(equipments: $equipments)
                        .padding(.horizontal, 10)
                    Spacer().frame(height: UIScreen.main.bounds.height*0.1)
                }
            }
            //  스크롤 뷰 하단에 그라데이션을 구현하기 위한 뷰 입니다.
            VStack {
                Spacer()
                Rectangle()
                    .fill(LinearGradient(colors: [.white.opacity(0.5), .black.opacity(0.15)], startPoint: .top, endPoint: .bottom))
                    .frame(height: 10)
            }
        }
        .modifier(CloseKeyboardModifier(isShowKeyboard: $isShowKeyboard))
        .navigationTitle("운동 생성")
        //  isShowIconView가 true가 되었을 시 IconSelectView를 호출합니다.
        .navigationDestination(isPresented: $isShowIconView, destination: {
            IconSelectView(selectColor: $selectColor, sfIconName: $sfIconName)
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("생성") {
                    let object = ExerciseFormStruct(imageName: sfIconName, imageColorName: selectColor?.colorHex, name: self.name, explain: self.explain, parts: self.parts, detailParts: [], equipments: self.equipments)
                    createVM.clickCreateButton(object: object)
                    if !createVM.isAlert {
                        mode.callAsFunction()
                    }
                }
            }
        }
        .confirmationDialog("", isPresented: $isSelectImageAlert) {
            Button("사진") {}
            Button("아이콘") {self.isShowIconView.toggle()}
        } message: {
            Text("이미지 타입을 선택해주세요.")
        }
        .alert("생성 오류", isPresented: $createVM.isAlert) {
            Text("확인")
        }message: {
            Text(createVM.alertMessage)
        }
    }
}

struct CreateExerciseFormView_Previews: PreviewProvider {
    static var previews: some View {
        CreateExerciseFormView()
    }
}
