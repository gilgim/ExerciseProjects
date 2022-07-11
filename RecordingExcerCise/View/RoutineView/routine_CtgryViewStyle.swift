//
//  routine_CtgryViewStyle.swift
//  RecordingExcerCise
//
//  Created by KimWooJin on 2022/07/11.
//

import Foundation
import SwiftUI

//  카테고리 뷰에 들어갈
struct routine_CtgryViewContent : Hashable {
    
    //  루틴명
    var name : String?
    //  운동강도
    var strength : String?
    //  운동부위
    var bodyPart : [String]?
    //  운동들
    var exercise : [ex_CtgryViewContent]?
    
    func valueNilCheck()->Bool{
        guard name != nil, strength != nil, bodyPart != nil
        else{
            print("====== VALUE ======")
            print("name: \(String(describing: name))")
            print("strength: \(String(describing: strength))")
            print("bodyPart: \(String(describing: bodyPart))")
            print("exercise: \(String(describing: exercise))")
            return false
        }
        return true
    }
}

struct routine_CtgryViewStyle : View {
    @State var content : routine_CtgryViewContent
    @State var isEdit : Bool = false
    init(content:routine_CtgryViewContent){
        self.content = content
    }
    var body: some View{
        //  MARK: -nil 값이 없을 때
        if content.valueNilCheck(){
            ZStack{
                Color.brown
                ScrollView{
                    VStack(spacing:0){
                        Group{
                            HStack(spacing:0){
                                Spacer().frame(width: 16)
                                //  MARK: -루틴명
                                VStack(spacing:0){
                                    TitleView(title: Binding.constant("루틴명"), type: .constant(.two))
                                    RoundedRectangle(cornerRadius: 10)
                                        .foregroundColor(.white)
                                        .frame(height:40)
                                }
                                .frame(width: UIScreen.main.bounds.width/2-16-8.25)
                                Spacer().frame(width: 16.5)
                                //  MARK: -운동강도
                                VStack(spacing:0){
                                    TitleView(title: Binding.constant("운동강도"), type: .constant(.two))
                                    Strength(userStrength: self.$content.strength)
                                }
                                .frame(width: UIScreen.main.bounds.width/2-16-8.25)
                                Spacer().frame(width: 16)
                            }
                        }
                        //  MARK: -운동부위
                        Group{
                            TitleView(title: .constant("운동부위"), type: .constant(.onlyOne))
                            BodyPart(userArray: self.$content.bodyPart,isEdit: $isEdit)
                                .frame(width: 342, height: 90)
                        }
                        //  MARK: -운동
                        Group{
                            TitleView(title: .constant("운동"), type: .constant(.onlyOne))
                        }
                     }
                 }
            }
        }
        //  MARK: -nil 값이 있을 때
        else{
            
        }
    }
    //  MARK: -제목 뷰
    struct TitleView : View{
        enum TitleType {
            case onlyOne
            case two
        }
        @Binding var title : String
        @Binding var type : TitleType
        var body: some View{
            HStack{
                Text(title)
                    .font(Font.system(size: 20, weight: .semibold))
                    .lineSpacing(0.24)
                Spacer()
            }
            .padding(.horizontal,type == .onlyOne ? 16 : 0)
            .padding(.top,25)
            .padding(.bottom,5)
        }
    }
    //  MARK: -운동 강도 뷰
    struct Strength : View{
        enum Strength : String, CaseIterable{
            case babel = "강"
            case dumbel = "중"
            case machine = "약"
            case naked = "모름"
        }
        @State var array = Strength.allCases.map{return $0.rawValue}
        @Binding var userStrength : String?
        var body: some View{
            HStack(spacing:8){
                ForEach(array,id:\.self){ strength in
                    //  FIXME: 여기에 이미 선택 한 게 있으면 눌림 표시 해야함
                    Button{
                      userStrength = strength
                    }label: {
                        ZStack{
                            Rectangle()
                                .foregroundColor(.white)
                            Text(strength)
                        }
                    }
                    .frame(height:40)
                }
            }
        }
    }
    
    //  MARK: -운동 부위 뷰
    struct BodyPart : View{
        enum BodyPart : String, CaseIterable{
            case chest = "가슴"
            case back = "등"
            case lowerBody = "하체"
            case shoulder = "어깨"
            case arm = "팔"
            case abs = "복근"
        }
        @Binding var userArray : [String]?
        @Binding var isEdit : Bool
        var gridColumns : Array<GridItem> { Array(repeating: GridItem(spacing: 8), count: 5) }
        @State var array = BodyPart.allCases.map{return $0.rawValue}
        var body: some View{
            GeometryReader{ geo in
                Color.red
                LazyVGrid(columns:gridColumns) {
                    ForEach(array,id:\.self){ partName in
                        //  FIXME: 여기에 이미 선택 한 게 있으면 눌림 표시 해야함
                      Button{
                            if userArray != nil  {
                                if userArray!.contains(partName){
                                    userArray = userArray!.filter({ value in
                                        return value != partName
                                    })
                                }
                                else{
                                    userArray!.append(partName)
                                }
                            }
                        }label: {
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.white)
                                    .frame(width: geo.size.width/5-8, height: array.count > 5 ? geo.size.height/2 - 4 : geo.size.height)
                                Text(partName)
                            }
                        }
                    }
                }
            }
            .onAppear {
                self.array = BodyPart.allCases.map{return $0.rawValue}
            }
        }
    }
    //  MARK: -루틴 운동 뷰
    struct IndexView : View{
        @Binding var contents : ex_CtgryViewContent
        var body: some View{
            
        }
    }
}
