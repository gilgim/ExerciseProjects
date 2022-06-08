//
//  Exercise.swift
//  RecordingExcerCise
//
//  Created by KimWooJin on 2022/05/02.
//

import SwiftUI

struct ExerciseView: View {
    @State var searchText = ""
    @State var searchTouch = true
    var test = [0,1,2,3,4,5]
    var body: some View {
        ZStack{
            ZStack{
                Color.black
            }
            .ignoresSafeArea()
            ZStack{
                Color.Color_13
            }
            VStack{
                SearchBar(text: $searchText,isTouch: $searchTouch)
                    .padding(.top,10)
                ScrollView(.horizontal, showsIndicators: false){
                    BodyScrollView()
                        .padding(.trailing,8)
                        .padding(.leading,16)
                }
                .frame(width: 390, height: 40, alignment: .center)
                ScrollView{
                    if searchTouch{
                        Group{
                            ForEach(test,id:\.self){ i in
                                PersnalExerciseView()
                                    .padding(.horizontal,16)
                                    .padding(.top,10)
                            }
                        }
                    }
                    Button{
                        
                    }label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 13)
                                .foregroundColor(.Color_12)
                                .frame(height: 46)
                            Image(systemName: "plus")
                        }
                        
                            
                    }
                    .padding(.horizontal,16)
                    .padding(.vertical,10)
                }
                ZStack{
                    Color.white
                    Button{
                        
                    }label: {
                        ZStack{
                            
                            RoundedRectangle(cornerRadius: 13)
                                .padding(.top,3)
                        }
                    }
                    .padding(.horizontal,16)
                }
                .frame(height: 49)
            }
        }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView()
    }
}
/**
    검색바 밑 상단 몸 부위 스크롤 할려고 하는 뷰
 */
struct BodyScrollView : View{
    var body: some View{
        HStack
        {
                BodyPartView(title: "즐겨찾는 운동",width: 130)
            ForEach(BodyPart.allCases, id:\.self){ i in
                BodyPartView(title: i.rawValue)
            }
        }
    }
}
/**
    몸 부위 하나를 구성하는 뷰 
 */
struct BodyPartView : View{
    var title : String
    var width : CGFloat
    var height : CGFloat
    init(title:String,width:CGFloat = 55,height:CGFloat = 40){
        self.title = title
        self.width = width
        self.height = height
    }
    var body: some View {
        ZStack{
            Button{
                
            }label: {
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.white)
                    .overlay(Text("\(title)"))
            }
        }
        .frame(width: width, height: height, alignment: .center)
        .padding(.trailing,8)
        
    }
}

struct PersnalExerciseView : View {
    var body : some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.Color_12)
            ZStack{
                RoundedRectangle(cornerRadius: 13)
                    .foregroundColor(Color.Color_10)
                Text("가슴")
                    .foregroundColor(Color.Color_27)
            }
            .padding(EdgeInsets(top: 17.5, leading: 10, bottom: 17.5, trailing: 278))
            HStack{
                Text("벤치프레스")
                    .padding(.leading,90)
                Spacer()
            }
            Button{
                
            }label: {
                Image(systemName: "ellipsis")
                    .resizable()
                    .scaledToFit()
            }
            .padding(EdgeInsets(top: 28, leading: 316, bottom: 28, trailing: 10))
        }
        .frame(height: 80)
    }
}
