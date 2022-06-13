//
//  Exercise.swift
//  RecordingExcerCise
//
//  Created by KimWooJin on 2022/05/02.
//

import SwiftUI
import RealmSwift

struct ExerciseView: View {
    @State var searchText = ""
    @State var searchTouch = true
    @State var objectCount : Int = 0
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var test = [0,1,2,3,4,5]
    var body: some View {
        let realm = try! Realm()
        let result = realm.objects(Exercise.self)//.filter("exercisePart == \(searchText)")
        ZStack{
            ZStack{
                Color.white
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
                            ForEach(0..<objectCount,id:\.self){ i in
                                PersnalExerciseView(count:i){
                                    objectCount = result.count
                                }
                                    .padding(.horizontal,16)
                                    .padding(.top,10)
                            }
                        }
                    }
                    NavigationLink{
                        CreatExercise()
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
                        try! realm.write {
                            if result.count > 0{
                                realm.delete(result[0])
                            }
                        }
                        objectCount = result.count
                    }label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 13)
                                .padding(.vertical,3)
                        }
                    }
                    .padding(.horizontal,16)
                }
                .frame(height: 49)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button{
                }label: {
                    Text("선택")
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button{
                    self.mode.wrappedValue.dismiss()
                }label: {
                    Text("< 날짜 선택")
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear(){
            let realm = try! Realm()
            let result = realm.objects(Exercise.self)//.filter("exercisePart == \(searchText)")
            objectCount = result.count
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
    var action : ((String)->())?
    init(title:String,width:CGFloat = 55,height:CGFloat = 40,action:((String)->())? = nil){
        self.title = title
        self.width = width
        self.height = height
        self.action = action
    }
    var body: some View {
        ZStack{
            Button{
                action?(title)
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
    var count : Int
    var action : (()->())?
    @State var isShowingPopover = false
    init(count:Int = 0,action:(()->())? = nil){
        self.count = count
        self.action = action
    }
    var body : some View {
        let realm = try! Realm()
        let result = realm.objects(Exercise.self)//.filter("exercisePart == \(searchText)")
        if result.count >= count {
            ZStack{
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(.Color_12)
                ZStack{
                    RoundedRectangle(cornerRadius: 13)
                        .foregroundColor(Color.Color_10)
                    Text(result[count].exercisePart!)
                        .foregroundColor(Color.Color_27)
                }
                .padding(EdgeInsets(top: 17.5, leading: 10, bottom: 17.5, trailing: 278))
                HStack{
                    Text(result[count].name!)
                        .padding(.leading,90)
                    Spacer()
                }
                Button{
//                    let realm = try! Realm()
//                    let result = realm.objects(Exercise.self)
//                    try! realm.write {
//                        if result.count >= count && result.count > 0{
//                            realm.delete(result[count])
//                            action?()
//                        }
//                    }
                    isShowingPopover = true
                }label: {
                    Image(systemName: "ellipsis")
                        .resizable()
                        .scaledToFit()
                        .contextMenu(){
                                Button {
                                    print("Change country setting")
                                } label: {
                                    Label("Choose Country", systemImage: "globe")
                                }

                                Button {
                                    print("Enable geolocation")
                                } label: {
                                    Label("Detect Location", systemImage: "location.circle")
                                }
                        }
                }
                .padding(EdgeInsets(top: 28, leading: 316, bottom: 28, trailing: 10))
            }
            .frame(height: 80)

        }
        else {
            ZStack{
                
            }
        }
    }
}

