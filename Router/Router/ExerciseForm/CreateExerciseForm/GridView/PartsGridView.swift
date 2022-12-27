//
//  PartsGridView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/20.
//

import SwiftUI

struct PartsGridView: View {
    //  ===== User Inputs =====
    /// 유저가 이전에 클릭하여 저장되어 있는 근육 부위를 뜻합니다.
    @Binding var stackPart: BodyPart?
    /// 유저가 선택한 근육 부위를 뜻 합니다.
    @Binding var parts: [BodyPart]
    
    //  ===== About View =====
    /// BodyPart의 모든 요소를 포함한 배열입니다.
    var bodyArray: [BodyPart] = BodyPart.allCases
    /// 4개의 요소를 가지고 있어 4개의 행을 출력 할 수 있도록 하는 GridItem 입니다.
    var colorRows: [GridItem] = .init(repeating: GridItem(.flexible(),spacing: 10), count: 4)
    
    var body: some View {
        LazyVGrid(columns: colorRows,alignment: .leading) {
            ForEach(bodyArray, id: \.self) { part in
                Button {
                    withAnimation {
                        //  현재 클릭한 버튼이 이전 클릭으로 stackPart에 저장되어 있을 때 할당 해제를 위한 if 입니다.
                        if self.stackPart == part {
                            //  현재 요소를 포함한다면 제외시킵니다.
                            if self.parts.contains(where: {$0 == part}) {
                                self.parts = self.parts.filter({$0 != part})
                                self.stackPart = nil
                                return
                            }
                            //  현재 요소가 없을 경우에는 추가시킵니다.
                            else {
                                self.parts.append(part)
                            }
                        }
                        //  현재 클릭한 버튼이 이전 클릭과 다를 때의 세부부위를 갱신하기 위한 if 입니다.
                        //  StackPart에 현재와 다른 부위가 있을 경우에는 현재 부위를 클릭하므로써 현재의 세부부위를 불러옵니다.
                        else {
                            //  스택에 있는 값과 다르지만 포함되어있지 않다면 클릭과 즉시 추가되어야합니다.
                            if !(self.parts.contains(where: {$0 == part})) {
                                self.parts.append(part)
                            }
                        }
                        //  조건과 상관 없이 현재 스택은 교체됩니다.
                        //  (제외시킬 때는 위에서 return 되어지기 때문에 밑으로 흐르지 않습니다.)
                        self.stackPart = part
                    }
                }label: {
                    ZStack {
                        Text(part.rawValue)
                            .modifier(BackRoundedRecModifier(cornerValue: 8, isSelect:.constant(self.parts.contains {$0 == part})))
                    }
                }
            }
        }
    }
}

struct PartsGridView_Previews: PreviewProvider {
    static var previews: some View {
        PartsGridView(stackPart: .constant(.Chest), parts: .constant([]))
    }
}
