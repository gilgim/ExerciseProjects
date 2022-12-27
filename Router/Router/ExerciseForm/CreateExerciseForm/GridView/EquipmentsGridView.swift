//
//  EquipmentsGridView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/21.
//

import SwiftUI

struct EquipmentsGridView: View {
    //  ===== User Input =====
    /// 사용자가 선택한 운동 방법 배열 입니다.
    @Binding var equipments: [Equipment]
    
    //  ==== About View =====
    /// Equipment의 모든 요소를 담은 배열입니다.
    var equipmentArray: [Equipment] = Equipment.allCases
    
    var body: some View {
        HStack {
            ForEach(equipmentArray, id: \.self) { equipment in
                Button {
                    //  현재 요소를 포함하고 있으면 제외시키기 위한 if 입니다.
                    if equipments.contains(where: {$0 == equipment}) {
                        equipments = equipments.filter({$0 != equipment})
                    }
                    //  현재 요소를 포함하지 않으면 추가합니다.
                    else {
                        equipments.append(equipment)
                    }
                }label: {
                    ZStack {
                        Text(equipment.rawValue)
                            .modifier(BackRoundedRecModifier(cornerValue: 8, isSelect:.constant(self.equipments.contains {$0 == equipment})))
                    }
                }
            }
        }
        .frame(height: 40)
    }
}

struct EquipmentsGridView_Previews: PreviewProvider {
    static var previews: some View {
        EquipmentsGridView(equipments: .constant([]))
    }
}
