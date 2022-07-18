//
//  exerContentView.swift
//  RecordingExcerCise
//
//  Created by KimWooJin on 2022/06/20.
//
//  루틴, 운동 목록에 보여지는 뷰로 형식을 지정해줘 Input값에 따라 조정되게 하여 반복적인 로직을 줄이고함.

import Foundation
import SwiftUI
import RealmSwift

struct CommonContentView : View{
    @State var text = ""
    @State var isTouch = false
    @Binding var contents : [ExerciseModel]?
    @Binding var type : IndexView.IndexType 
    var body: some View{
        ZStack{
            Color.Color_13
            Color.Color_13.edgesIgnoringSafeArea(.bottom)
            VStack{
                SearchBar(text: $text, isTouch: $isTouch)
                    .background(Color.Color_13)
                ScrollView{
                    //  FIXME: 여기서 분기쳐서 루틴이랑 운동이랑 구분해주기
                    VStack{
                        if let contents = contents {
                            ForEach(contents, id: \.name){ content in
                                if text != "" && content.name!.contains(text){
                                    IndexView(content: content, type: type)
                                }
                                else if text == "" {
                                    IndexView(content: content, type: type)
                                }
                            }
                        }
                        NavigationLink{
                            let temp = Binding<ExerciseModel>.constant(ExerciseModel())
                            exercise_CtgryView(content:temp)
                        }label: {
                            RoundedRectangle(cornerRadius: 13)
                                .foregroundColor(.white)
                                .frame(height: 46)
                                .overlay(Image(systemName: "plus"))
                                .padding(.horizontal,16)
                        }
                        Spacer()
                    }
                }
                ZStack(alignment:.top){
                    Rectangle()
                        .foregroundColor(.Color_09)
                    Button{
                        
                    }label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 13)
                            Label("운동 기록",systemImage: "calendar.badge.plus")
                                .foregroundColor(.white)
                        }
                    }
                    .frame(height: 46)
                    .padding(.horizontal,16)
                }
                .ignoresSafeArea()
                .frame(height:83-34)
            }
        }
        .onTapGesture {
            self.hideKeyboard()
        }
    }
    struct IndexView : View {
        enum IndexType {
            case exercise
            case routine
        }
        @Binding var content : ExerciseModel
        @Binding var type : IndexType
        init(content : ExerciseModel = ExerciseModel(), type : IndexType = .exercise){
            self._content = Binding.constant(content)
            self._type = Binding.constant(type)
        }
        var body: some View{
            ZStack{
                HStack(spacing:0){
                    if content.name != nil {
                        ZStack{
                            let text = content.detailPart![0] == "" || content.detailPart![0] == "+" ? content.bodyPart![0] : content.detailPart![0]
                            Text(text)
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
                        
                        Menu{
                            Button(role:.destructive){
                                let realm = try! Realm()
                                realm.delete(content.managedObject())
                            }label: {
                                Text("제거")
                                Image(systemName: "trash")
                            }
                            Button{
                                
                            }label: {
                                Text("운동 정보")
                                Image(systemName: "info.circle")
                            }
                            Button{
                            }label: {
                                Text("운동 복제")
                                Image(systemName: "doc.on.doc")
                            }
                            Button{
                            }label: {
                                Text("즐겨찾기")
                                Image(systemName: "heart")
                            }
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

