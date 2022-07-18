//
//  ex_CtgryViewStyle.swift
//  RecordingExcerCise
//
//  Created by KimWooJin on 2022/06/20.
//
//  운동 또는 루틴을 생성 및 편집 할 때 쓰는 뷰를 형식화하여 반복적인 로직을 줄이고자함.

import Foundation
import SwiftUI
import RealmSwift

struct exercise_CtgryView : View {
    //  MARK: -공통요소
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @State var isAlert = false
    @State var errorMessage = ""
    //  MARK: -생성된 운동 정보를 불러 올 때 필요한 정보
    @Binding var content : ExerciseModel
    @State var isEdit : Bool = false
    
    //  MARK: -운동 생성 시 필요한 정보
    //  운동명
    @State var name = ""
    //  동작설명
    @State var explain = ""
    //  운동부위
    @State var part : [String]? = []
    //  세부부위
    @State var detailPart : [String]? = ["+"]
    //  장비
    @State var equipment : [String]? = []
    var body: some View{
        //  MARK: -nil 값이 없을 때
        if content.isNotNil(){
            ZStack{
                Color.Color_13
                Color.Color_09.edgesIgnoringSafeArea(.bottom)
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
        //  MARK: -운동 목록을 생성할 때
        else{
            ZStack{
                Color.Color_13
                Color.Color_09.edgesIgnoringSafeArea(.bottom)
                ScrollView{
                    VStack(spacing:0){
                         //  MARK: -운동명
                         Group{
                             HStack{
                                 Text("운동명")
                                     .font(Font.system(size: 20, weight: .semibold))
                                     .lineSpacing(0.24)
                                 Spacer()
                             }
                             .padding(.top,20)
                             .padding(.bottom,5)
                             .padding(.horizontal,16)
                             ZStack{
                                 RoundedRectangle(cornerRadius: 13)
                                     .foregroundColor(.white)
                                 TextField("운동명을 입력해주세요.",text: $name)
                                     .padding(.horizontal,10)
                             }
                             .frame(height: 50)
                             .padding(.horizontal,16)
                         }
                        //  MARK: -동작 설명
                        Group{
                            HStack{
                                Text("동작 설명")
                                    .font(Font.system(size: 20, weight: .semibold))
                                    .lineSpacing(0.24)
                                Spacer()
                            }
                            .padding(.top,20)
                            .padding(.bottom,5)
                            .padding(.horizontal,16)
                            ZStack{
                                RoundedRectangle(cornerRadius: 15)
                                    .frame(width: 358, height: 358, alignment: .center)
                                    .foregroundColor(.white)
                                TextEditor(text: $explain)
                                    .padding(10)
                            }
                            .padding(.horizontal,16)
                        }
                         //  MARK: -링크
                         Group{
                             Button{
                                 print(part)
                                 print(detailPart)
                                 print(equipment)
                             }label: {
                                 RoundedRectangle(cornerRadius: 13)
                                     .frame(width: 358, height: 60, alignment: .center)
                                     .foregroundColor(.white)
                                     .overlay(HStack{Image(systemName: "link");Text(" 링크 생성")})
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
                            bodyPartView(userArray: $part, isSelect: $isEdit, type: .bodyPart)
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
                            bodyPartView(userArray: $detailPart, isSelect: $isEdit,type: .detailPart)
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
                            bodyPartView(userArray: $equipment, isSelect: $isEdit, type: .equipment)
                                .frame(idealWidth: UIScreen.main.bounds.width,idealHeight: 45)
                                .padding(.horizontal,16)
                                .padding(.top,5)
                        }
                     }
                 }
            }
            .onTapGesture {
                self.hideKeyboard()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        if name == ""{
                            isAlert = true
                            errorMessage = "운동명을 입력해주세요."
                        }
                        else if part == []{
                            isAlert = true
                            errorMessage = "운동부위를 선택해주세요."
                        }
                        else if equipment == []{
                            isAlert = true
                            errorMessage = "장비를 선택해주세요."
                        }
                        if !isAlert{
                            let temp = ExerciseModel(name: name, explain: explain, bodyPart: part, detailPart: detailPart, equipment: equipment, link: "", linkTitle: "")
                            let container = try! Container()
                            try! container.write({ realm in
                                realm.add(temp)
                            })
                            mode.wrappedValue.dismiss()
                        }

                    }label: {
                        Text("완료")
                    }
                }
            }
            .alert(isPresented: $isAlert) {
                Alert(title: Text(errorMessage), message: nil, dismissButton: .default(Text("확인")))
            }
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
            LazyVGrid(columns:gridColumns) {
                ForEach(array,id:\.self){ partName in
                    if partName == "+"{
                      NavigationLink(){
                          Text("세부부위 만들거임")
                      }label: {
                          ZStack{
                              RoundedRectangle(cornerRadius: 12)
                                  .foregroundColor(.white)
                                  .frame(width: geo.size.width/5-8, height: array.count > 5 ? geo.size.height/2 - 4 : geo.size.height)
                              Text(partName)
                          }
                      }
                    }
                    else{
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
                                  RoundedRectangle(cornerRadius: 12)
                                      .foregroundColor(.white)
                                      .frame(width: geo.size.width/5-8, height: array.count > 5 ? geo.size.height/2 - 4 : geo.size.height)
                                  RoundedRectangle(cornerRadius: 12)
                                      .stroke(userArray!.contains(partName) ? Color.Color_19 : Color.white, lineWidth: userArray!.contains(partName) ? 1.5 : 0)
                                      .foregroundColor(userArray!.contains(partName) ? .Color_12 : .white)
                                      .frame(width: geo.size.width/5-8, height: array.count > 5 ? geo.size.height/2 - 4 : geo.size.height)
                                  Text(partName)
                                      .font(userArray!.contains(partName) ? Font.system(size: 17, weight: .bold, design: .rounded) : Font.system(size: 17, weight: .regular, design: .rounded))
                                      .foregroundColor(userArray!.contains(partName) ? .Color_27 : .black)
                              }
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
}
