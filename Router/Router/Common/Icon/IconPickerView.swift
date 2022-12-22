//
//  IconPickerView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/20.
//

import SwiftUI

struct IconPickerView: View {
    //  MARK: - User Input
    /// -   Korean :   유저가 선택하는 SF symbol 이름, Realm에 String으로 저장된다.
    /// -   English :
    @Binding var systemName: String?
    //  MARK: - About View
    /// -   개발자가 등록하는 SFsymbol 이름과 이미지 구조의 배열
    var iconArray: [SFIconImage] = SFIconImage.iconArray
    /// -   Grid 뷰에서 행, 또는 열 개수의 대한 값이 배열의 개수로 정해진다.
    var iconRows: [GridItem] = .init(repeating: GridItem(.adaptive(minimum: UIScreen.main.bounds.height*0.3/6),spacing: 0), count: 5)
    
    var body: some View {
        //  -   아이콘의 추가 사용을 위한 ScrollView
        ScrollView(.horizontal, showsIndicators: false) {
            //  -   HGrid로 표현하여 아이콘 추가의 진행 방향을 세로로 정한다.
            LazyHGrid(rows: iconRows, spacing: 10) {
                ForEach(iconArray, id: \.id) { icon in
                    Button {
                        self.systemName = self.systemName == icon.systemName ? nil : icon.systemName
                    }label: {
                        icon.image.foregroundColor(.black)
                    }
                }
            }
            .padding(.horizontal, 10)
        }
        .modifier(BackRoundedRecModifier(cornerValue: 8))
        //  -   아이콘 픽커의 크기
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
/// -   Korean :    String으로 SFsymbol을 이용하기 위한 이미지와 이름을 가지고 있는 구조체.
/// -   English :
class SFIconImage {
    /// -   ForEach 의 id 로 사용하기 위한 UUID.
    var id = UUID()
    /// -   Korean :    뷰와 데이터 모두 사용하기 위한 배열 값
    /// -   English :
    static var iconArray: [SFIconImage] = [.walk, .run, .roll, .coreTraining, .cooldown
                                           , .wrestling, .strengthtraining, .step, .stairs, .stepper
                                           , .rolling, .pilates, .cycle, .flexibility, .functional
                                           , .swim, .climbing]
    var image: Image
    var systemName: String
    //  -   초기화 시 String 값만으로 image까지 할당한다.
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
