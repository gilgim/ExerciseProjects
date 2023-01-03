//
//  DetailPartView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/21.
//

import SwiftUI

struct DetailPartFormView: View {
    //    ===== User Input =====
    /// 상위뷰에서 클릭한 운동 부위입니다.
    @Binding var affiliatedPart: BodyPart
    ///    상위뷰에서 할당한 세부 운동 입니다.
    @Binding var superDetailParts: [DetailPartFormStruct]?
    ///    사용자가 세부 부위를 만들 때 사용하는 텍스트 입니다.
    @State var detailPartName: String = ""
    /// 사용자가 삭제 할 세부부위 입니다.
    @State var deleteDetailPart: DetailPartFormStruct?
    
    //    ===== About View =====
    @StateObject var detailPartVM = DetailPartFormViewModel()
    @State var isCreateView: Bool = false
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                //  plus 버튼 클릭 시 세부부위를 만들 수 있는 팝업이 발생합니다.
                Button {
                    self.isCreateView.toggle()
                }label: {
                    Image(systemName: "plus")
                        .modifier(BackRoundedRecModifier(cornerValue: 8))
                }
                ForEach (detailPartVM.detailPartsArray, id: \.name) { detailPart in
                    Text(detailPart.name)
                        .modifier(BackRoundedRecModifier(cornerValue: 8, isSelect: .constant(superDetailParts?.contains(where: {$0 == detailPart}) ?? false)))
                        .onTapGesture {
                            withAnimation {
                                //  버튼 클릭 시 상위 뷰에 세부부위를 추가합니다.
                                self.superDetailParts = self.superDetailParts == nil ? [] : self.superDetailParts
                                //  현재 요소를 포함하고 있으면 배열에서 제외시키는 if문 입니다.
                                if superDetailParts!.contains(where: {$0 == detailPart}) {
                                    self.superDetailParts = superDetailParts!.filter({$0 != detailPart})
                                }
                                //  현재 요소를 포함하지 않으면 추가시키는 else문 입니다.
                                else {
                                    self.superDetailParts?.append(detailPart)
                                }
                            }
                        }
                        .onLongPressGesture {
                            self.deleteDetailPart = detailPart
                        }
                }
                Spacer()
            }
            .padding(.leading, 10)
            .padding(.vertical)
        }
        .frame(height: 40)
        .onAppear() {
            self.detailPartVM.detailPartsArray = self.detailPartVM.renewSelectPart(part: self.affiliatedPart)
        }
        //  유저가 선택한 운동 부위가 바뀔 때 동작하는 Change 입니다.
        .onChange(of: self.affiliatedPart, perform: { newValue in
            //  배열을 갱신합니다.
            self.detailPartVM.detailPartsArray = self.detailPartVM.renewSelectPart(part: newValue)
        })
        //    유저가 세부부위를 생성하기 위한 Alert 입니다.
        .alert("세부부위 생성", isPresented: $isCreateView) {
            TextField("부위명",text: $detailPartName)
            Button("생성") {
                //  유저가 입력한 값을 해당 배열에 추가합니다.
                self.detailPartVM.createButtonAction(part: affiliatedPart, name: self.detailPartName)
                //  배열을 갱신합니다.
                self.detailPartVM.detailPartsArray = self.detailPartVM.renewSelectPart(part: affiliatedPart)
                //  생성과 상관 없이 버튼 클릭 시
                self.detailPartName = ""
            }
            Button("취소", role: .cancel) {}
        }message: {
            Text("선택할 세부부위를 생성해주세요.")
        }
        //  생성 오류가 발생할 때 detailVm를 통해 팝업되는 알림입니다.
        .alert("생성 알림", isPresented: $detailPartVM.isAlert) {
            Text("확인")
        }message: {
            Text(detailPartVM.alertMessage)
        }
        //  오래 눌러 삭제 시 발생되는 팝업입니다.
        .alert("삭제 알림", isPresented: .constant(deleteDetailPart != nil)) {
            Button("삭제", role: .destructive) {
                withAnimation {
                    if let deleteDetailPart {
                        self.detailPartVM.detailLongTap(target: deleteDetailPart)
                    }
                    //  클릭한 값을 비워줍니다.
                    self.deleteDetailPart = nil
                    //  배열을 업데이트합니다.
                    self.detailPartVM.detailPartsArray = self.detailPartVM.renewSelectPart(part: self.affiliatedPart)
                }
            }
            Button("취소", role: .cancel) {}
        }message: {
            if let deleteDetailPart {
                Text("\(deleteDetailPart.name)을 삭제하시겠습니까?")
            }
        }
    }
}

struct DetailPartFormView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPartFormView(affiliatedPart: .constant(.Chest), superDetailParts: .constant([]))
    }
}
