//
//  CreatExercise.swift
//  RecordingExcerCise
//
//  Created by KimWooJin on 2022/06/10.
//

import SwiftUI
/**
    운동 생성 뷰
 */
struct CreatExercise: View {
    @State var exName : String = ""
    @State var exExplain : String = ""
    @State var part : BodyPart = .chest
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var body: some View {
        ZStack{
            ZStack{
                Color.white
            }
            .edgesIgnoringSafeArea(.top)
            ZStack{
                Color.Color_13
            }.edgesIgnoringSafeArea(.bottom)
        
            ScrollView{
                VStack{
                    EmptyRecView(name: Binding<String>.constant("운동명"), explain: $exName,inputType: .constant(.TextField))
                    EmptyRecView(name: Binding<String>.constant("동작 설명"), explain: $exExplain, height: Binding<CGFloat?>.constant(358),inputType: .constant(.TextEditor))
                    EmptyRecView(inputType: .constant(.Link))
                    EmptyRecView(name:Binding<String>.constant("운동 부위"),inputType:.constant(.Part))
                    EmptyRecView(name:Binding<String>.constant("장비"),inputType:.constant(.Equipment))
                    Text("\(part.rawValue)")
                    Spacer()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button{
                    createExercisePart(name: exName, explain: exExplain, equipment: .babel, part: part)
                    self.mode.wrappedValue.dismiss()
                }label: {
                    Text("완료")
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button{
                    self.mode.wrappedValue.dismiss()
                }label: {
                    Text("취소")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
/**
    계속 사용할 텍스트와 그 밑 상자 표현한 뷰
 */
struct EmptyRecView: View {
    enum InputType {
        case TextField
        case TextEditor
        case Link
        case Part
        case Equipment
        case null
    }
    @Binding var name : String
    @Binding var explain : String
    @Binding var height : CGFloat?
    @Binding var link : String
    @Binding var inputType : InputType
    @Binding var part : BodyPart
    init(name: Binding<String> = .constant(""), explain: Binding<String> = .constant(""), height: Binding<CGFloat?> = .constant(50),inputType: Binding<InputType>,link : Binding<String> = .constant("링크 생성"), part:Binding<BodyPart> = .constant(.chest)){
        self._name = name
        self._explain = explain
        self._height = height
        self._inputType = inputType
        self._link = link
        self._part = part
    }
    
    var body: some View {
        VStack{
            HStack{
                Text("\(name)")
                Spacer()
            }
            .padding(.top,20)
            .padding(.bottom,5)
            ZStack{
                RoundedRectangle(cornerRadius: 13)
                    .foregroundColor(inputType == .Part || inputType == .Equipment ? .clear : .Color_01)
                HStack{
                    VStack{
                        if inputType == .TextField{
                            TextField("예) 벤치프레스",text: $explain)
                                .padding(10)
                        }
                        else if inputType == .TextEditor{
                            TextEditor(text:$explain)
                                .padding(10)
                        }
                        else if inputType == .Part{
                            ScrollView(.horizontal,showsIndicators: false){
                                HStack{
                                    ForEach(BodyPart.allCases, id:\.self){ i in
                                        BodyPartView(title: i.rawValue,part: .constant(part.rawValue))
                                    }
                                }
                            }
                        }
                        else if inputType == .Equipment{
                            HStack{
                                ForEach(Equipment.allCases, id:\.self){ i in
                                    BodyPartView(title: i.rawValue)
                                }
                            }
                        }
                    }
                    .frame(height:height)
                    Spacer()
                }
                if inputType == .Link {
                    Button{
                        
                    }label: {
                        HStack{
                            Image(systemName: "link.badge.plus")
                            Text("\(link)")
                        }
                    }
                }
            }
        }
        .padding(.horizontal,16)
    }
}
/**
    Youtube 등 영상링크
 */
struct LinkView : View{
    var body: some View{
        VStack{
            
        }
    }
}
