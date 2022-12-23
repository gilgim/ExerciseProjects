//
//  EquipmentsGridView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/21.
//

import SwiftUI

struct EquipmentsGridView: View {
    //  MARK: - User Inputs
    @Binding var equipments: [Equipment]
    //  MARK: - About Views
    var equipmentArray: [Equipment] = Equipment.allCases
    var body: some View {
        HStack {
            ForEach(equipmentArray, id: \.self) { equipment in
                //  -   버튼 클릭 시 폰트 변경 및 테두리 변경이 진행된다.
                Button {
                    if equipments.contains(where: {$0 == equipment}) {
                        equipments = equipments.filter({$0 != equipment})
                    }
                    else {
                        equipments.append(equipment)
                    }
                }label: {
                    ZStack {
                        Text(equipment.rawValue)
                            .modifier(ButtonTitle(isSelect: .constant(self.equipments.contains {$0 == equipment})))
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
