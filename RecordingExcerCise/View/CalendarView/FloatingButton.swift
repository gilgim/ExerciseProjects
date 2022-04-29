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
    private(set) var action: (() -> Void)? = nil
}

struct ExpandableButtonView: View {
    let primaryItem: ExpandableButtonItem
    let secondaryItems: [ExpandableButtonItem]
    let none: () -> Void = {}
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
                            
                            Button(action: secondaryItems[0].action ?? self.none)
                            {
                                ZStack{
                                    Circle()
                                    ZStack{
                                        Image(systemName: secondaryItems[0].image)
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.white)
                                    }
                                    .padding(18)
                                }
                            }
                            Spacer().frame(width: 16)
                        }
                        Spacer().frame(height: isShowGray ? height*0.292072322670376 : height*0.091743119266055)
                    }
                    .transition(.offset(x: 0, y: 140))
                    
                    VStack{
                        Spacer().frame(height: height*0.721835883171071)
                        HStack{
                            Spacer().frame(width: width*0.8051292)
                            
                            Button(action: secondaryItems[1].action ?? self.none)
                            {
                                ZStack{
                                    Circle()
                                    ZStack{
                                        Image(systemName: secondaryItems[1].image)
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.white)
                                    }
                                    .padding(18)
                                }
                            }
                            Spacer().frame(width: 16)
                        }
                        Spacer().frame(height: height*0.19471488178025)
                    }
                    .transition(.offset(x: 0, y: 70))
                    
                    VStack{
                        Spacer().frame(height: height*0.916550764951321)
                        HStack{
                            Spacer().frame(width: width*0.8051292)
                            
                            Button(action: secondaryItems[2].action ?? self.none)
                            {
                                ZStack{
                                    Circle()
                                    ZStack{
                                        Image(systemName: secondaryItems[2].image)
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.white)
                                    }
                                    .padding(18)
                                }
                            }
                            Spacer().frame(width: 16)
                        }
                    }
                    .transition(.offset(x: 0, y: -70))
                }
                
                //  클릭하는 뷰
                VStack{
                    Spacer().frame(height: height*0.829619921363)
                    HStack{
                        Spacer().frame(width: width*0.8051292)
                        
                        Button(action: {
                            withAnimation {
                                print(height)
                                self.isExpanded.toggle()
                                self.isShowGray.toggle()
                            }
                            self.primaryItem.action?()
                        }) {
                            ZStack{
                                Circle()
                                ZStack{
                                    Image(systemName: "calendar.badge.plus")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.white)
                                        .offset(x:2,y: 2)
                                }
                                .padding(18)
                            }
                        }
                        
                        Spacer().frame(width: 16)
                    }
                    Spacer().frame(height: height*0.091743119266055)
                }
            }
        }
    }
}
struct AnimatedExpandableButton: View {
    @State var text = "none"
    @Binding var isShowGray : Bool
    var body: some View {
        ZStack {
            ExpandableButtonView(
                primaryItem: ExpandableButtonItem(image: "plus", label:""),
                secondaryItems: [
                    ExpandableButtonItem(image: "lock.rotation.open", label: "Lock") {
                        withAnimation() { self.text = "Lock" }
                    },
                    ExpandableButtonItem(image: "xmark.bin", label: "Delete") {
                        withAnimation() { self.text = "Delete" }
                    },
                    ExpandableButtonItem(image: "archivebox", label: "Archive") {
                        withAnimation() { self.text = "Archive" }
                    } ], isShowGray: self.$isShowGray )
            
        }
    }
}

struct AnimatedExpandableButton_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedExpandableButton(isShowGray: .constant(false))
    }
}
