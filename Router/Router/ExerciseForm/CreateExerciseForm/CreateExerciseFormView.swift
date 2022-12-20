//
//  CreateExerciseFormView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/19.
//

import SwiftUI

struct CreateExerciseFormView: View {
    //  MARK: - 사용자 입력 관련
    @State var selectColor: Color?
    @State var sfIconName: String?
    /// 운동 이름
    @State var name: String = ""
    ///
    @State var explain: String = ""
    //  MARK: - View 관련
    @State var isSelectImage: Bool = false
    @State var isShowIconView: Bool = false
    @State var isShowKeyboard: Bool = false
    var body: some View {
        ScrollView {
            VStack {
                /// **이미지 뷰**
                Button {
                    self.isSelectImage.toggle()
                }label: {
                    Circle()
                        .modifier(CustromCircleModifier(selectColor: $selectColor, sfIconName: $sfIconName))
                        .frame(width: 150)
                        .padding(.vertical, 10)
                }
                /// **이름 TextField**
                CustomTextEditor("이름", text: $name)
                    .modifier(BackRoundedRecModifier(cornerValue: 8))
                    .frame(height: UIScreen.main.bounds.height * 0.08)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 10)
                
                /// **설명 TextField && 유튜브 링크 생성 버튼**
                CustomTextEditor("설명", text: $explain, isLink: true)
                    .modifier(BackRoundedRecModifier(cornerValue: 8))
                    .frame(height: UIScreen.main.bounds.height * 0.2)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 10)
                /// **운동 부위 선택 버튼**
                TitleView(title: "운동 부위")
                    .padding(.bottom, 5)
                
                /// **운동 방법 선택 버튼**
                TitleView(title: "운동 방법")
                    .padding(.bottom, 5)
                Spacer()
            }
        }
        .modifier(CloseKeyboardModifier(isShowKeyboard: $isShowKeyboard))
        //  MARK: - View 관련 설정 (알림, 네비게이션 바, 등등)
        .navigationTitle("운동 생성")
        .navigationDestination(isPresented: $isShowIconView, destination: {
            IconSelectView(selectColor: $selectColor, sfIconName: $sfIconName)
        })
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
