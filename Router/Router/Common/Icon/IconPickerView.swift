//
//  IconPickerView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/20.
//

import SwiftUI

struct IconPickerView: View {
    @Binding var systemName: String?
    var iconArray: [SFIconImage] = SFIconImage.iconArray
    /// rows의 개수가 총 뷰가 그리는 행 값이다.
    var iconRows: [GridItem] = .init(repeating: GridItem(.adaptive(minimum: UIScreen.main.bounds.height*0.3/6),spacing: 0), count: 5)
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: iconRows, spacing: 10) {
                ForEach(iconArray, id: \.id) { icon in
                    Button {
                        self.systemName = icon.systemName
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

struct IconPickerView_Previews: PreviewProvider {
    static var previews: some View {
        IconPickerView(systemName: .constant(""))
    }
}

class SFIconImage {
    var id = UUID()
    static var iconArray: [SFIconImage] = [.walk, .run, .roll, .coreTraining, .cooldown
                                           , .wrestling, .strengthtraining, .step, .stairs, .stepper
                                           , .rolling, .pilates, .cycle, .flexibility, .functional
                                           , .swim, .climbing]
    var image: Image
    var systemName: String
    init(systemName: String) {
        self.systemName = systemName
        self.image = .init(systemName: systemName)
    }
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
