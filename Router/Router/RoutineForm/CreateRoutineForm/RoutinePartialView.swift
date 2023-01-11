//
//  RoutinePartialView.swift
//  Router
//
//  Created by KimWooJin on 2023/01/03.
//

import SwiftUI

struct RoutinePartialView: View {
    let id = UUID()
    @State var int: Int
    @Binding var setArray: [RoutineComponentType]
    @State var viewSetArray: [RoutineComponentType] = []
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                //  마지막 부분을 감지하기 위하여 숫자로 감지합니다.
                ForEach(viewSetArray.indices, id: \.description) { i in
                    if nil != viewSetArray[i].value as? Int {
                        Circle()
                            .modifier(CustomCircleModifier(color: .cyan, iconName: "bed.double.fill", 18, whiteLinePadding: 6, lineWidth: 3))
                    }
                    if let exerciseString = viewSetArray[i].value as? String {
                        if let exerciseList = RouterApp.exerciseList {
                            let iconName = exerciseList.filter({$0.name == exerciseString})[0].imageName
                            Circle()
                                .modifier(CustomCircleModifier(color: .cyan, iconName: iconName, 15, whiteLinePadding: 6, lineWidth: 3))
                        }
                    }
                    if viewSetArray.count-1 == i {
                        Divider()
                            .overlay(Color.gray)
                    }
                    else {
                        Image(systemName: "arrowshape.forward.fill")
                    }
                }
                
                Button {
                    self.viewSetArray.append(RoutineComponentType.Rest(time: 60))
                }label: {
                    Circle()
                        .modifier(CustomCircleModifier(color: .cyan, iconName: "plus", 15, whiteLinePadding: 6, lineWidth: 3))
                }
                
                Spacer().frame(width: 100)
            }
        }
        .modifier(BackRoundedRecModifier(cornerValue: 12))
        .modifier(ListDragBlock(color: .yellow, imageColor: .accentColor))
        .frame(height: 100)
        .onChange(of: self.viewSetArray) { _ in
            self.setArray = self.viewSetArray
        }
    }
}
struct RoutinePartialView_Previews: PreviewProvider {
    static var previews: some View {
        RoutinePartialView(int: 0,setArray: .constant([.Exercise(name: "asdf"), .Rest(time: 60), .Rest(time: 60), .Rest(time: 60)]))
    }
}
