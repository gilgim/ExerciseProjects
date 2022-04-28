//
//  MainTapView.swift
//  RecordingExcerCise
//
//  Created by KimWooJin on 2022/03/18.
//

import SwiftUI

struct MainTapView: View {
    @State private var selection = 0
    @State private var naviTitle = ""
    @State private var naviShow = false
    //  아이템바 클릭 이벤트
    var handler : Binding<Int>{
        return Binding {
            self.selection
        } set: { value in
            if value == 1 {
                naviShow = true
                naviTitle = "3월"
            }
            else {
                naviShow = false
            }
            self.selection = value
        }

    }
    
    var body: some View {
        NavigationView{
            ZStack{
                TabView(selection:handler){
                    ZStack{
                        CalendarView()
                        
                    }
                    .tabItem {
                        VStack{
                            Image(systemName: "calendar")
                            Text("기록")
                        }
                    }
                    .tag(0)
                    
                    Text("f")
                        .tabItem {
                            Image(systemName: "calendar")
                            Text("기록")
                        }
                        .tag(1)
                }
                .navigationBarHidden(naviShow)
            }
        }
    }
}
#if DEBUG
struct MainTapView_Previews: PreviewProvider {
    static var previews: some View {
        MainTapView()
    }
}
#endif
