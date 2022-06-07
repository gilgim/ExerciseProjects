//
//  Exercise.swift
//  RecordingExcerCise
//
//  Created by KimWooJin on 2022/05/02.
//

import SwiftUI

struct ExerciseView: View {
    @State var searchText = ""
    var body: some View {
        ZStack{
            Color.Color_13
            Color.Color_13
                .edgesIgnoringSafeArea(.bottom)
            VStack{
                SearchBar(text: $searchText)
                    .padding(.top,10)
                ScrollView(.horizontal, showsIndicators: false){
                    BodyScrollView()
                        .padding(.trailing,8)
                        .padding(.leading,16)
                }
                .frame(width: 390, height: 40, alignment: .center)
                
                Spacer()
            }
        }
    }
}

struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseView()
    }
}

struct SearchBar: View {
    @Binding var text: String
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
 
                TextField("Search", text: $text)
                    .foregroundColor(.primary)
 
                if !text.isEmpty {
                    Button(action: {
                        self.text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                    }
                } else {
                    EmptyView()
                }
            }
            .padding(EdgeInsets(top: 10, leading: 16, bottom: 10, trailing: 16))
            .foregroundColor(.secondary)
            .background(.gray.opacity(0.2))
            .cornerRadius(10.0)
        }
        .padding(.horizontal)
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
