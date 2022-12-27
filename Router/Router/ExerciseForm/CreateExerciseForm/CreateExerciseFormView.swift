//
//  CreateExerciseFormView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/19.
//

import SwiftUI

struct CreateExerciseFormView: View {
    //  MARK: - User Inputs
    /// -   유저 선택 컬러로 선택하지 않을 시 기본 회색이다.
    @State var selectColor: Color?
    /// -   유저 선택 컬러 선택하지 않을 시 기본 값인 Dumbell.fill 이다.
    @State var sfIconName: String?
    /// -   운동을 구분하는 값으로 유일 값이다. nil 이나 ""는 저장될 수 없다.
    @State var name: String = ""
    /// -   설명은 nil과 빈 값을 허용한다. 하지만 ""일 시 nil이 저장된다.
    @State var explain: String = ""
    /// -   운동 부위는 유저마다 같은 운동이라도 다르게 설정될 수 있다.
    @State var parts: [BodyPart] = []
    /// -   세부부위는 nil를 허용한다. 배열의 개수가 0일 시 nil이 저장된다.
    @State var detailParts: [DetailPartFormStruct] = []
    /// -   운동 방법은 같은 운동이라도 유저마다 다른 기구를 사용하기 때문에 배열 값이다.
    @State var equipments: [Equipment] = []
    //  MARK: - About Views
    /// -   이미지를 사진 또는 아이콘으로 선택하기 위한 Alert에 바인딩 되어있다.
    @State var isSelectImage: Bool = false
    /// -   Alert에서 icon 클릭 시 iconView를 push하는 네비게이션과 바인딩 되어있다.
    @State var isShowIconView: Bool = false
    /// -   키보드가 내려갔을 때를 인식하기 위한 State 값이다.
    @State var isShowKeyboard: Bool = false
    /// -   디테일 뷰를 호출하기 위한 값으로 유저가 부위를 선택하면 갱신된다.
    @State var currentClickPart: BodyPart?
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    /// **이미지 뷰**
                    Button {
                        self.isSelectImage.toggle()
                    }label: {
                        Circle()
                            .modifier(CustomCircleModifier(color: self.selectColor, iconName: self.sfIconName == nil ? "plus" : self.sfIconName))
                            .frame(width: 150)
                            .padding(.vertical, 10)
                    }
                    /// **이름 TextField**
                    CustomTextEditor("이름", text: $name)
                        .fontWeight(.bold)
                        .modifier(BackRoundedRecModifier(cornerValue: 8))
                        .frame(height: UIScreen.main.bounds.height * 0.08)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                    
                    /// **설명 TextField && 유튜브 링크 생성 버튼**
                    CustomTextEditor("설명", text: $explain, isLink: true)
                        .modifier(BackRoundedRecModifier(cornerValue: 8))
                        .frame(height: UIScreen.main.bounds.height * 0.3)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                    
                    /// **운동 부위 선택 버튼**
                    TitleView(title: "부위 선택")
                        .padding(.bottom, 5)
                    PartsGridView(stackPart: $currentClickPart, parts: $parts)
                        .padding(.horizontal, 10)
                    
                    /// **세부 부위 선택 버튼**
                    if let currentClickPart, !parts.isEmpty {
                        TitleView(title: "\(currentClickPart.rawValue) 세부 선택")
                        DetailPartView(affiliatedPart: $currentClickPart)
                    }
                    
                    /// **운동 방법 선택 버튼**
                    TitleView(title: "운동 방법")
                        .padding(.bottom, 5)
                    EquipmentsGridView(equipments: $equipments)
                        .padding(.horizontal, 10)
                    Spacer().frame(height: UIScreen.main.bounds.height*0.1)
                }
            }
            /// **바텀 그라데이션**
            VStack {
                Spacer()
                Rectangle()
                    .fill(LinearGradient(colors: [.white.opacity(0.5), .black.opacity(0.15)], startPoint: .top, endPoint: .bottom))
                    .frame(height: 10)
            }
        }
        .modifier(CloseKeyboardModifier(isShowKeyboard: $isShowKeyboard))
        .navigationTitle("운동 생성")
        .navigationDestination(isPresented: $isShowIconView, destination: {
            IconSelectView(selectColor: $selectColor, sfIconName: $sfIconName)
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("생성") {}
            }
        }
        .confirmationDialog("", isPresented: $isSelectImage) {
            Button("사진") {}
            Button("아이콘") {self.isShowIconView.toggle()}
        } message: {
            Text("이미지 타입을 선택해주세요.")
        }
    }
}

struct CreateExerciseFormView_Previews: PreviewProvider {
    static var previews: some View {
        CreateExerciseFormView()
    }
}
