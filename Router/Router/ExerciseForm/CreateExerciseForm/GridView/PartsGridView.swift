//
//  PartsGridView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/20.
//

import SwiftUI

struct PartsGridView: View {
    //  MARK: - User Input
    @Binding var currentPart: BodyPart?
    @Binding var parts: [BodyPart]
    /// -   개발자가 추가한 운동할 수 있는 부위. 추가하기 위해서는 Enum case를 추가하여야 한다.
    var bodyArray: [BodyPart] = BodyPart.allCases
    var colorRows: [GridItem] = .init(repeating: GridItem(.flexible(),spacing: 10), count: 4)
    var body: some View {
        LazyVGrid(columns: colorRows,alignment: .leading) {
            ForEach(bodyArray, id: \.self) { part in
                Button {
                    /**
                        @ When - 버튼을 처음 클릭 시: 디테일 뷰를 공개하고 유저의 운동부위에 해당 부위를 추가한다.
                        @ When - 클릭된 버튼을  클릭 시: 유저가 이전에 클릭한 버튼과 같은 값이라면 해당 값을 배열에서 제거하고 아니라면 디테일 뷰를 클릭 값으로 갱신한다.
                     */
                    withAnimation {
                        if self.currentPart == part {
                            if self.parts.contains(where: {$0 == part}) {
                                self.parts = self.parts.filter({$0 != part})
                                self.currentPart = nil
                                return
                            }
                            else {
                                self.parts.append(part)
                            }
                        }
                        else {
                            var isContain = false
                            for index in parts {
                                if index == part {
                                    isContain = true
                                    break
                                }
                            }
                            if !isContain {self.parts.append(part)}
                            else {
                                self.parts = self.parts.filter({$0 != part})
                                self.parts.append(part)
                            }
                        }
                        self.currentPart = part
                    }
                //  FIXME: Binding을 통해 폰트 및 클릭 후 구현하는 Modifier을 구현하기
                }label: {
                    ZStack {
                        Text(part.rawValue)
                            .font(Font.system(size: 18,
                                              weight: self.parts.contains {$0 == part} ? .semibold:.regular,
                                              design: .rounded))
                            .modifier(BackRoundedRecModifier(cornerValue: 8, isSelect:.constant(self.parts.contains {$0 == part})))
                        if self.parts.contains {$0 == part} {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 5)
                                .foregroundColor(.middleBluePurple)
                        }
                    }
                }
            }
        }
    }
}

struct PartsGridView_Previews: PreviewProvider {
    static var previews: some View {
        PartsGridView(currentPart: .constant(.Chest), parts: .constant([]))
    }
}
