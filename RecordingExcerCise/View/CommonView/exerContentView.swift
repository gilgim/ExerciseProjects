//
//  exerContentView.swift
//  RecordingExcerCise
//
//  Created by KimWooJin on 2022/06/20.
//
//  루틴, 운동 목록에 보여지는 뷰로 형식을 지정해줘 Input값에 따라 조정되게 하여 반복적인 로직을 줄이고함.

import Foundation
import SwiftUI

struct exerContentView : View{
    @State var text = ""
    @State var isTouch = false
    @Binding var contents : [CtgryViewContent]?
    var body: some View{
        ZStack{
            
            Color.Color_13
            Color.Color_13.edgesIgnoringSafeArea(.bottom)
            VStack{
                SearchBar(text: $text, isTouch: $isTouch)
                    .background(Color.Color_13)
                    .onChange(of: text) { newValue in
                        print(newValue)
                    }
                ScrollView{
                    VStack{
                        if let contents = contents {
                            ForEach(contents, id:\.self){ content in
                                if text != "" && content.name!.contains(text){
                                    IndexView(content: Binding.constant(content))
                                }
                                else if text == "" {
                                    IndexView(content: Binding.constant(content))
                                }
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
        .onTapGesture {
            self.hideKeyboard()
        }
    }
    struct IndexView : View {
        @Binding var content : CtgryViewContent
        var body: some View{
            ZStack{
                HStack(spacing:0){
                    if content.name != nil {
                        ZStack{
                            Text(content.detailPart![0])
                                .lineLimit(1)
                                .font(Font.system(size: 15))
                                .padding(10)
                                .foregroundColor(.Color_27)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 13).foregroundColor(.Color_10)
                        )
                        .padding(.horizontal,10)
                        Text(content.name!)
                            .font(Font.system(size: 15))
                            .frame(height: 45, alignment: .leading)
                            .padding(.vertical,17.5)
                        Spacer()
                        Button{
                            
                        }label: {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 28)
                                .padding(.trailing,12)
                        }
                    }
                    else{
                        EmptyView()
                    }
                }
                .frame(width: UIScreen.main.bounds.width-32, height: 80,alignment: .leading)
                .background(.white)
                .cornerRadius(15)
            }
        }
    }
}

