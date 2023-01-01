//
//  DetailPartView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/21.
//

import SwiftUI

struct DetailPartFormView: View {
	//	===== User Input =====
    /// 상위뷰에서 클릭한 운동 부위입니다.
    @Binding var affiliatedPart: BodyPart?
	///	상위뷰에서 할당한 세부 운동 입니다.
	@Binding var superDetailPart: DetailPartFormStruct?
	///	사용자가 세부 부위를 만들 때 사용하는 텍스트 입니다.
	@State var detailPartName: String = ""
	
	//	===== About View =====
	@StateObject var detailPartVM = DetailPartFormViewModel()
	@State var isCreateView: Bool = false
	
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Button {
					self.isCreateView.toggle()
                }label: {
                    Image(systemName: "plus")
                        .modifier(BackRoundedRecModifier(cornerValue: 8))
                }
				ForEach (detailPartVM.detailPartsArray, id: \.self) { detailPart in
					Button {
						if var superDetailPart {
							if superDetailPart.name.contains(detailPart) {
								superDetailPart.name = superDetailPart.name.filter({$0 != detailPart})
							}
							else {
								superDetailPart.name.append(detailPart)
							}
						}
					}label: {
						Text(detailPart)
					}
					.modifier(BackRoundedRecModifier(cornerValue: 8))
                }
				.onChange(of: superDetailPart?.affiliatedPart) { _ in
					if let affiliatedPart = superDetailPart?.affiliatedPart {
						detailPartVM.renewSelectPart(part: affiliatedPart)
					}
				}
                Spacer()
            }
            .padding(.leading, 10)
        }
        .frame(height: 40)
		//	유저가 세부부위를 생성하기 위한 Alert 입니다.
		.alert("세부부위 생성", isPresented: $isCreateView) {
			TextField("부위명",text: $detailPartName)
			Button("생성") {
				//	유저가 입력한 값을 해당 배열에 추가합니다.
				self.detailPartVM.detailPartsArray.append(detailPartName)
				self.detailPartVM.createButtonAction()
				//  생성과 상관 없이 버튼 클릭 시
				self.detailPartName = ""
			}
			Button("취소", role: .cancel) {}
		}message: {
			Text("선택할 세부부위를 생성해주세요.")
		}
    }
}

struct DetailPartFormView_Previews: PreviewProvider {
    static var previews: some View {
		DetailPartFormView(affiliatedPart: .constant(.Chest), superDetailPart: .constant(.init(affiliatedPart: .Chest, name: [])))
    }
}
