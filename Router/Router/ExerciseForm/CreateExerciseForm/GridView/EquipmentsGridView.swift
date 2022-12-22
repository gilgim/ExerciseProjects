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
                            .font(Font.system(size: 18,
                                              weight: equipments.contains(where: {$0 == equipment}) ? .semibold:.regular,
                                              design: .rounded))
                            .modifier(BackRoundedRecModifier(cornerValue: 8))
                        if self.equipments.contains {$0 == equipment} {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 5)
                                .foregroundColor(.middleBluePurple)
                        }
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
