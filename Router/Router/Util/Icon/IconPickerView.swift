//
//  IconPickerView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/20.
//

import SwiftUI

struct IconPickerView: View {
    //  ===== User Input =====
    @Binding var systemName: String?
    //  ===== About View =====
    var iconArray: [SFIconImage] = SFIconImage.iconArray
    /// 행의 값으로 5개의 행을 구현하기 위해서 배열 요소의 개수는 5개 입니다.
    var iconRows: [GridItem] = .init(repeating: GridItem(.adaptive(minimum: UIScreen.main.bounds.height*0.3/6),spacing: 0), count: 5)
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: iconRows, spacing: 10) {
                ForEach(iconArray, id: \.id) { icon in
                    Button {
                        //  아이콘 문양을 정할 시 재 클릭하면 nil를 대입하여 상위 뷰에서 nil에 대한 기댓값을 표현합니다.
                        self.systemName = self.systemName == icon.systemName ? nil : icon.systemName
                    }label: {
                        icon.image.foregroundColor(.black)
                    }
                }
            }
            .padding(.horizontal, 10)
        }
        .modifier(BackRoundedRecModifier(cornerValue: 8))
        .frame(height: UIScreen.main.bounds.height*0.3)
        .padding(.horizontal, 10)
    }
}
//  MARK: - Previews
struct IconPickerView_Previews: PreviewProvider {
    static var previews: some View {
        IconPickerView(systemName: .constant(""))
    }
}
//  MARK: - Structs
/// String으로 Image 와 SF Symbol 이름을 동시에 가지고 있게 하기위한 구조체 입니다.
class SFIconImage {
    /// ForEach 의 id 로 사용하기 위한 UUID 값 입니다.
    var id = UUID()
    /// Image 타입과 String 타입을 한번에 가지는 구조체를 배열로 사용하여 배열이 사용되는 뷰에서 두 값을 같이 쓰게합니다.
    static var iconArray: [SFIconImage] = [.walk, .run, .roll, .coreTraining, .cooldown
                                           , .wrestling, .strengthtraining, .step, .stairs, .stepper
                                           , .rolling, .pilates, .cycle, .flexibility, .functional
                                           , .swim, .climbing]
    var image: Image
    var systemName: String
    /**
     -  parameters:
        -   systemName: SF symbol 로써 Image 와 String 둘 다 핢당합니다.
     */
    init(systemName: String) {
        self.systemName = systemName
        self.image = .init(systemName: systemName)
    }
    //  MARK: - ICon Group
    static var walk: SFIconImage = .init(systemName: "figure.walk")
    static var run: SFIconImage = .init(systemName: "figure.run")
    static var roll: SFIconImage = .init(systemName: "figure.roll")
    static var coreTraining: SFIconImage = .init(systemName: "figure.core.training")
    static var cooldown: SFIconImage = .init(systemName: "figure.cooldown")
    static var wrestling: SFIconImage = .init(systemName: "figure.wrestling")
    static var strengthtraining: SFIconImage = .init(systemName: "figure.strengthtraining.traditional")
    static var step: SFIconImage = .init(systemName: "figure.step.training")
    static var stairs: SFIconImage = .init(systemName: "figure.stairs")
    static var stepper: SFIconImage = .init(systemName: "figure.stair.stepper")
    static var rolling: SFIconImage = .init(systemName: "figure.rolling")
    static var pilates: SFIconImage = .init(systemName: "figure.pilates")
    static var cycle: SFIconImage = .init(systemName: "figure.indoor.cycle")
    static var flexibility: SFIconImage = .init(systemName: "figure.flexibility")
    static var functional: SFIconImage = .init(systemName: "figure.strengthtraining.functional")
    static var swim: SFIconImage = .init(systemName: "figure.pool.swim")
    static var climbing: SFIconImage = .init(systemName: "figure.climbing")
}
