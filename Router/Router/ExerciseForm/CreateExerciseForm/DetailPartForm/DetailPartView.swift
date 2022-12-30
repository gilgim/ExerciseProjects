//
//  DetailPartView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/21.
//

import SwiftUI

struct DetailPartView: View {
    /// 상위뷰에서 클릭한 운동 부위입니다.
    @Binding var affiliatedPart: BodyPart?
    @State var detailParts: [DetailPartFormStruct] = []
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                Button {
                    
                }label: {
                    Image(systemName: "plus")
                        .modifier(BackRoundedRecModifier(cornerValue: 8))
                }
                ForEach (detailParts, id: \.name) { detailPart in
                    
                }
                Spacer()
            }
            .padding(.leading, 10)
        }
        .frame(height: 40)
    }
}

struct DetailPartView_Previews: PreviewProvider {
    static var previews: some View {
        DetailPartView(affiliatedPart: .constant(.Chest))
    }
}
