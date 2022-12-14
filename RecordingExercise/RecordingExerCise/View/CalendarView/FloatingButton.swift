//
//  FloatingButton.swift
//  RecordingExcerCise
//
//  Created by KimWooJin on 2022/04/28.
//

import Foundation
import SwiftUI

//  각 인스턴스 식별
struct ExpandableButtonItem: Identifiable {
    
    let id = UUID()
    let image: String
    let label: String
}

//  뷰
struct ExpandableButtonView: View {
    let primaryItem: ExpandableButtonItem
    let secondaryItems: [ExpandableButtonItem]
    let size: CGFloat = 70
    var cornerRadius: CGFloat = 35
    @State var isExpanded = false
    @Binding var isShowGray : Bool
    var body: some View {
        GeometryReader{ geo in
            ZStack {
                let width = geo.size.width
                let height = geo.size.height
                if isShowGray {
                    VStack{
                        Spacer().frame(height: isShowGray ? height*0.624478442280946 : height*0.829619921363)
                        HStack{
                            Spacer().frame(width: width*0.8051292)
                            //  MARK: -루틴
                            NavigationLink {
                                RoutineView()
                            } label: {
                                ZStack{
                                    Circle()
                                        .foregroundColor(.Color_20)
                                    ZStack{
                                        Image(systemName: secondaryItems[0].image)
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.white)
                                            .offset(x:0,y:-5)
                                        Text("\(secondaryItems[0].label)")
                                            .foregroundColor(.white)
                                            .font(Font.system(size: 12, weight: .regular, design: .rounded))
                                            .offset(x: 0, y: 16)
                                    }
                                    .padding(18)
                                }
                            }
                            Spacer().frame(width: 16)
                        }
                        Spacer().frame(height: isShowGray ? height*0.292072322670376 : height*0.091743119266055)
                    }
                    .transition(.offset(x: 0, y: height*0.097357440890125*2))
                    
                    VStack{
                        Spacer().frame(height: height*0.721835883171071)
                        HStack{
                            Spacer().frame(width: width*0.8051292)
                            //  MARK: -운동
                            NavigationLink {
                                ExerciseView()
                            } label: {
                                ZStack{
                                    Circle()
                                        .foregroundColor(.Color_21)
                                    ZStack{
                                        Image(systemName: secondaryItems[1].image)
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.white)
                                            .offset(x:0,y:-5)
                                        Text("\(secondaryItems[1].label)")
                                            .foregroundColor(.white)
                                            .font(Font.system(size: 12, weight: .regular, design: .rounded))
                                            .offset(x: 0, y: 16)
                                    }
                                    .padding(18)
                                }
                            }
                            Spacer().frame(width: 16)
                        }
                        Spacer().frame(height: height*0.19471488178025)
                    }
                    .transition(.offset(x: 0, y: height*0.097357440890125))
                    
                    VStack{
                        Spacer().frame(height: height*0.916550764951321)
                        HStack{
                            Spacer().frame(width: width*0.8051292)
                            //  MARK: -세팅
                            NavigationLink {
                                SettingView()
                                    .navigationTitle(Text("??"))
                            } label: {
                                ZStack{
                                    Circle()
                                        .foregroundColor(.Color_23)
                                    ZStack{
                                        Image(systemName: secondaryItems[2].image)
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.white)
                                            .offset(x:0,y:-5)
                                        Text("\(secondaryItems[2].label)")
                                            .foregroundColor(.white)
                                            .font(Font.system(size: 12, weight: .regular, design: .rounded))
                                            .offset(x: 0, y: 16)
                                    }
                                    .padding(18)
                                }
                            }
                            Spacer().frame(width: 16)
                        }
                    }
                    .transition(.offset(x: 0, y: -height*0.097357440890125))
                }
                
                //  MARK: -클릭해서 원 상태로 되돌리는 뷰
                VStack{
                    Spacer().frame(height: height*0.819193324061196)
                    HStack{
                        Spacer().frame(width: width*0.8051292)
                        
                        Button(action: {
                            withAnimation {
                                self.isExpanded.toggle()
                                self.isShowGray.toggle()
                            }
                        }) {
                            ZStack{
                                Circle()
                                    .foregroundColor(.Color_19)
                                ZStack{
                                    Image(systemName: "calendar.badge.plus")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.white)
                                        .offset(x:2,y: 2)
                                        .offset(x:0,y:-5)
                                    Text("시작")
                                        .foregroundColor(.white)
                                        .font(Font.system(size: 12, weight: .regular, design: .rounded))
                                        .offset(x: 0, y: 16)
                                }
                                .padding(18)
                            }
                        }
                        
                        Spacer().frame(width: 16)
                    }
                    Spacer().frame(height: height*0.097357440890125)
                }
            }
        }
    }
}

//  MARK: -Actions
struct AnimatedExpandableButton: View {
    @Binding var isShowGray : Bool
    var body: some View {
        ZStack {
            ExpandableButtonView(
                primaryItem: ExpandableButtonItem(image: "plus", label:""),
                secondaryItems: [
                    ExpandableButtonItem(image: "r.circle.fill", label: "루틴"),
                    ExpandableButtonItem(image: "e.circle.fill", label: "운동") ,
                    ExpandableButtonItem(image: "gearshape.fill", label: "설정")], isShowGray: self.$isShowGray )
            
        }
    }
}
//  MARK: -Preview
struct AnimatedExpandableButton_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedExpandableButton(isShowGray: .constant(false))
    }
}
