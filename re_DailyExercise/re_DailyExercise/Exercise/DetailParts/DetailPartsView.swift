//
//  DetailPartsView.swift
//  re_DailyExercise
//
//  Created by KimWooJin on 2022/09/23.
//

import Foundation
import SwiftUI

struct DetailPartsView: View {
	@StateObject var vm: DetailPartsViewModel
    @State var detailText: String = ""
    @State var isAlert: Bool = false
    @State var isErrorAlert: Bool = false
    @Binding var detailArray: [String]
    @Binding var part: String
    var body: some View {
        TitleView(isPadding: false, title: "세부 부위") {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach($vm.detailParts, id:\.self) { $detailPart in
                        Text($detailPart.wrappedValue)
                    }
                    Button {
                        isAlert.toggle()
                    }label: {
                        RoundedRecView(.white, cornerValue: 12) {
                            Image(systemName: "plus")
                                .foregroundColor(.buttonFontBlack)
                                .padding(.horizontal, 12)
                                .padding(.vertical,AboutSize.deviceSize[1]*0.012)
                                .font(.system(size: AboutSize.deviceSize[1]*0.021,weight: .regular))
                        }
                        .frame(width: 55, height: AboutSize.deviceSize[1]*0.055)
                        .shadow(color: .almostShadowColor.opacity(0.2), radius: 4,y: 3)
                    }
                }
                .padding(.leading, 16)
            }
        }
		.onAppear {
			self.vm.creatDetail()
		}
        .onChange(of: part, perform: { _ in
            vm.setPart(part: part)
            withAnimation {
                vm.updateDetailView()
            }
        })
        .alert("세부부위 생성", isPresented: $isAlert) {
            TextField("부위명",text: $detailText)
            Button("생성") {
                withAnimation {
                    if self.vm.detailParts.contains(detailText) || detailText == "" {
                        isErrorAlert.toggle()
                    }
                    else {
                        self.vm.detailParts.append(detailText)
                        self.vm.tempDetailParts.append(detailText)
						self.vm.detailParts = self.vm.detailParts.sorted()
						self.vm.tempDetailParts = self.vm.tempDetailParts.sorted()
                    }
                }
                self.detailText = ""
            }
            Button("취소", role: .cancel) {}
        }message: {
            Text("선택할 세부부위를 생성해주세요.")
        }
        .alert("오류",isPresented: $isErrorAlert) {
            Button("확인",role: .cancel) {}
        }message: {
            Text("이미 존재하는 값 입니다. 생성할 수 없습니다.")
        }
    }
	func viewModelUpdate() {
		vm.updateDetail()
	}
}
