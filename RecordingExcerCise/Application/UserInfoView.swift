//
//  UserInfoView.swift
//  RecordingExcerCise
//
//  Created by KimWooJin on 2022/03/18.
//

import SwiftUI

struct UserInfoView: View {
    @State var textTemp1 = ""
    @State var inputButtonShow = true
    var body: some View {
        NavigationView{
            
            GeometryReader{ geo in
                
                Color.gray.opacity(0.3)
                    .ignoresSafeArea()
                
                let bottomAllSafeArea : CGFloat = 34
                let geoWidth = geo.size.width
                let geoHeight = UIScreen.main.bounds.height - geo.safeAreaInsets.top - bottomAllSafeArea
                
                ZStack{
                        ScrollView{
                            
                            VStack(spacing:0){
                                
                                Text("일지 작성에 앞서\n기본정보 입력을 부탁드려요.")
                                    .font(.system(size: 28, weight: .bold))
                                
                                //  MARK: 로고 이미지
                                Rectangle()
                                    .frame(height:geoHeight*0.2239)
                                    .padding(.horizontal,geoHeight*0.1599)
                                    .padding(.vertical,geoHeight*0.0668)
                                
                                VStack(spacing:geoHeight*0.0278){
                                    
                                    //  MARK: 이름
                                    RoundedRectangle(cornerRadius: 13)
                                        .overlay(
                                            HStack{
                                                Text("이름 :")
                                                    .padding(.leading,15)
                                                    .padding(.vertical,10)
                                                    .font(.system(size: 20, weight: .regular))
                                                
                                                TextField("",text:$textTemp1) { Bool in
                                                    
                                                    if Bool {
                                                        inputButtonShow = false
                                                    }
                                                    
                                                    else{
                                                        inputButtonShow = true
                                                    }
                                                    
                                                }
                                                .padding(.vertical,20)
                                                .font(.system(size: 20, weight: .regular))
                                            }
                                            .foregroundColor(.black)
                                        )
                                    
                                    HStack(spacing:8){
                                        
                                        //  MARK: 성별
                                        RoundedRectangle(cornerRadius: 13)
                                            .overlay(
                                                HStack(spacing:0){
                                                    Text("성별")
                                                        .padding(.horizontal,15)
                                                        .padding(.vertical,10)
                                                        .font(.system(size: 20, weight: .regular))
                                                    
                                                    HStack(spacing:10){
                                                        
                                                        Button{
                                                            
                                                        }label: {
                                                            Text("남")
                                                                .foregroundColor(.black)
                                                        }
                                                        .buttonStyle(buttonStyler(roundCorner: 10, customOpacity: 0.7, color: .buttonColor))
                                                        
                                                        Button{
                                                            
                                                        }label: {
                                                            Text("여")
                                                                .foregroundColor(.black)
                                                        }
                                                        .buttonStyle(buttonStyler(roundCorner: 10, customOpacity: 0.7, color: .buttonColor))
                                                        
                                                    }
                                                    .gesture(DragGesture().onChanged({ value in
                                                            print(value)
                                                    }))
                                                    .foregroundColor(.buttonColor)
                                                    .padding(.vertical,10)
                                                    .padding(.trailing,15)
                                                }
                                                .foregroundColor(.black)
                                            )
                                        
                                        //  MARK: 나이
                                        RoundedRectangle(cornerRadius: 13)
                                            .overlay(
                                                HStack{
                                                    Text("나이 :")
                                                        .padding(.leading,15)
                                                        .padding(.vertical,10)
                                                        .font(.system(size: 20, weight: .regular))
                                                    
                                                    TextField("",text: $textTemp1)
                                                        .padding(.vertical,20)
                                                        .multilineTextAlignment(.center)
                                                    
                                                    Text("세")
                                                        .padding(.trailing,15)
                                                    
                                                }
                                                .foregroundColor(.black)
                                                .font(.system(size: 20, weight: .regular))
                                            )
                                    }
                                    
                                    //  MARK: 키
                                    RoundedRectangle(cornerRadius: 13)
                                        .overlay(
                                            HStack{
                                                Text("키 : ")
                                                    .padding(.leading,15)
                                                    .padding(.vertical,10)
                                                    .font(.system(size: 20, weight: .regular))
                                                
                                                TextField("",text: $textTemp1)
                                                    .frame(width:geoWidth*0.2077)
                                                
                                                HStack(spacing:8){
                                                    
                                                    Button{
                                                        
                                                    }label: {
                                                        RoundedRectangle(cornerRadius: 13)
                                                            .overlay(
                                                                Text("남")
                                                                    .foregroundColor(.black)
                                                            )
                                                    }
                                
                                                    
                                                    Button{
                                                        
                                                    }label: {
                                                        RoundedRectangle(cornerRadius: 13)
                                                            .overlay(
                                                                Text("여")
                                                                    .foregroundColor(.black)
                                                            )
                                                    }
                                                }
                                                .padding(.vertical,10)
                                                .padding(.trailing,106)
                                            }
                                            .foregroundColor(.black)
                                        )
                                    
                                    //  MARK: 몸무게
                                    RoundedRectangle(cornerRadius: 13)
                                        .overlay(
                                            HStack{
                                                Text("몸무게 : ")
                                                    .padding(.leading,15)
                                                    .padding(.vertical,10)
                                                    .font(.system(size: 20, weight: .regular))
                                                
                                                TextField("",text: $textTemp1)
                                                    .frame(width:geoWidth*0.2077)
                                                
                                                HStack(spacing:8){
                                                    
                                                    Button{
                                                        
                                                    }label: {
                                                        RoundedRectangle(cornerRadius: 13)
                                                            .overlay(
                                                                Text("남")
                                                                    .foregroundColor(.black)
                                                            )
                                                    }
                                                    
                                                    Button{
                                                        
                                                    }label: {
                                                        RoundedRectangle(cornerRadius: 13)
                                                            .overlay(
                                                                Text("여")
                                                                    .foregroundColor(.black)
                                                            )
                                                    }
                                                }
                                                .padding(.vertical,10)
                                                .padding(.trailing,71)
                                            }
                                            .foregroundColor(.black)
                                        )
                                    
                                }
                                .foregroundColor(.white)
                                .padding(.horizontal,16)
                                .frame(height:geoHeight*0.4172)
                                
                                Spacer()
                                    .frame(height:geoHeight*0.3199)
                            }
                        }
                    
                    .frame(width: geoWidth, height: geoHeight-bottomAllSafeArea)
                    .padding(.bottom,geo.safeAreaInsets.bottom)
                    
                    VStack{
                        
                        Spacer()
                            .frame(height:geoHeight-geoHeight*0.0605)
                        
                        Button{
                            
                            print(UIScreen.main.bounds.height)
                            print(geoHeight)
                        }label: {
                            if inputButtonShow{
                                RoundedRectangle(cornerRadius: 13)
                                    .overlay(
                                        Text("입력 완료")
                                            .foregroundColor(.white)
                                            .font(.system(size: 17, weight: .regular))
                                    )
                            }
                        }
                        
                    }
                    .padding(.horizontal,16)
                }
                .frame(width: geoWidth, height: geoHeight)
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct buttonStyler : ButtonStyle{
    
    var roundCorner : Double
    var customOpacity : Double
    var color : Color
    func makeBody(configuration: Configuration) -> some View {
        ZStack{
            RoundedRectangle(cornerRadius: roundCorner)
                .overlay(Color.black.opacity(configuration.isPressed ? 0.5 : 0).cornerRadius(roundCorner))
            configuration.label
        }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView()
    }
}

