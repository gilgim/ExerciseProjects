//
//  ex_CtgryViewStyle.swift
//  RecordingExcerCise
//
//  Created by KimWooJin on 2022/06/20.
//
//  운동 또는 루틴을 생성 및 편집 할 때 쓰는 뷰를 형식화하여 반복적인 로직을 줄이고자함.

import Foundation
import SwiftUI

//  카테고리 뷰에 들어갈
struct ex_CtgryViewContent : Hashable {
    //  운동명
    var name : String?
    //  동작설명
    var explain : String?
    //  운동부위
    var bodyPart : [String]?
    //  세부부위명칭
    var detailPart : [String]?
    //  장비
    var equipment : [String]?
    var link : String?
    var linkTitle : String?
    
    var setCount = 0
    var count = 0
    var RPE : Double = 0
    
    func valueNilCheck()->Bool{
        guard name != nil, explain != nil, bodyPart != nil, detailPart != nil, equipment != nil, link != nil, linkTitle != nil
        else{
            print("====== VALUE ======")
            print("name: \(String(describing: name))")
            print("explain: \(String(describing: explain))")
            print("bodyPart: \(String(describing: bodyPart))")
            print("detailPart: \(String(describing: detailPart))")
            print("equipment: \(String(describing: equipment))")
            print("linkTitle: \(String(describing: linkTitle))")
            print("link: \(String(describing: link))")
            return false
        }
        return true
    }
}
struct ex_CtgryViewStyle : View {
    @State var content : ex_CtgryViewContent
    @State var isEdit : Bool = false
    init(content:ex_CtgryViewContent){
        self.content = content
    }
    var body: some View{
        //  MARK: -nil 값이 없을 때
        if content.valueNilCheck(){
            ZStack{
                Color.brown
                ScrollView{
                    VStack(spacing:0){
                         //  MARK: -운동명
                         Group{
                             // 운동 편집 중일 때
                             if isEdit{
                                     HStack{
                                         Text("\(content.name!)")
                                     }
                                     Rectangle()
                             }
                             //  운동 편집 중이 아닐 때
                             else{
                                 HStack{
                                     Text("\(content.name!)")
                                         .font(Font.system(size: 20, weight: .semibold))
                                         .lineSpacing(0.24)
                                     Spacer()
                                 }
                                 .padding(.top,20)
                                 .padding(.bottom,5)
                                 .padding(.horizontal,16)
                                 ZStack{
                                     Rectangle()
                                         .frame(width: 358, height: 358, alignment: .center)
                                         .foregroundColor(.white)
                                     ScrollView{
                                         Text("\(content.explain!)")
                                             .padding(15)
                                     }
                                 }
                                 .padding(.horizontal,16)
                             }
                         }
                         //  MARK: -링크
                         Group{
                             Button{
                                 
                             }label: {
                                 Rectangle()
                                     .frame(width: 358, height: 60, alignment: .center)
                                     .foregroundColor(.white)
                                     .overlay(HStack{Image(systemName: "link");Text(" \(content.linkTitle!)")})
                                     .padding(.top,20)
                             }
                         }
                        //  MARK: -운동부위
                        Group{
                            HStack{
                                Text("운동부위")
                                    .font(Font.system(size: 20, weight: .semibold))
                                    .lineSpacing(0.24)
                                Spacer()
                            }
                            .padding(.top,25)
                            .padding(.horizontal,16)
                            bodyPartView(userArray: self.$content.bodyPart, isSelect: $isEdit, type: .bodyPart)
                                .frame(idealWidth: UIScreen.main.bounds.width,idealHeight: 98)
                                .padding(.horizontal,16)
                                .padding(.top,5)
                        }
                        //  MARK: -세부부위
                        Group{
                            HStack{
                                Text("세부부위")
                                    .font(Font.system(size: 20, weight: .semibold))
                                    .lineSpacing(0.24)
                                Spacer()
                            }
                            .padding(.top,25)
                            .padding(.horizontal,16)
                            bodyPartView(userArray: self.$content.detailPart, isSelect: $isEdit,type: .detailPart)
                                .frame(idealWidth: UIScreen.main.bounds.width,idealHeight: 45)
                                .padding(.horizontal,16)
                                .padding(.top,5)
                        }
                        //  MARK: -장비
                        Group{
                            HStack{
                                Text("장비")
                                    .font(Font.system(size: 20, weight: .semibold))
                                    .lineSpacing(0.24)
                                Spacer()
                            }
                            .padding(.top,25)
                            .padding(.horizontal,16)
                            bodyPartView(userArray: self.$content.equipment, isSelect: $isEdit, type: .equipment)
                                .frame(idealWidth: UIScreen.main.bounds.width,idealHeight: 45)
                                .padding(.horizontal,16)
                                .padding(.top,5)
                        }
                     }
                 }
            }
        }
        //  MARK: -nil 값이 있을 때
        else{
            
        }
    }
}

//  MARK: -그리드뷰
struct bodyPartView : View{
    enum BodyPart : String, CaseIterable{
        case chest = "가슴"
        case back = "등"
        case lowerBody = "하체"
        case shoulder = "어깨"
        case arm = "팔"
        case abs = "복근"
    }
    enum Equipment : String, CaseIterable{
        case babel = "바벨"
        case dumbel = "덤벨"
        case machine = "머신"
        case naked = "맨몸"
    }
    enum ViewType {
        case bodyPart
        case detailPart
        case equipment
    }
    
    @Binding var userArray : [String]?
    @Binding var isSelect : Bool
    
    var type : ViewType
    var gridColumns : Array<GridItem> { Array(repeating: GridItem(spacing: 8), count: 5) }
    @State var array = BodyPart.allCases.map{return $0.rawValue}
    
    var body: some View{
        GeometryReader{ geo in
            Color.red
            LazyVGrid(columns:gridColumns) {
                ForEach(array,id:\.self){ partName in
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
            switch type {
            case .bodyPart:
                self.array = BodyPart.allCases.map{return $0.rawValue}
            case .detailPart:
                self.array = self.userArray != nil ? self.userArray! : ["+"]
            case .equipment:
                self.array = Equipment.allCases.map{return $0.rawValue}
            }
        }
    }
    
    struct buttonStyle : ButtonStyle {
        var isSelected = true
        func makeBody(configuration: Configuration) -> some View {
            
        }
    }
}
