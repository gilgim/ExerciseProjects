//
//  CalendarView.swift
//  RecordingExcerCise
//
//  Created by KimWooJin on 2022/03/18.
//

import SwiftUI
import UIKit
import FSCalendar

struct CalendarView: View {
    
    @StateObject var viewModel = CalendarViewModel()
    @State var showblind = false
    
    //  타이틀 형식
    var TitleString : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 M월"
        return dateFormatter.string(from: viewModel.currentPage)
    }
    
    var body: some View {
        
        //  뷰의 움직임을 위한 Navigation
        NavigationView{
            GeometryReader{ geo in
                let width = geo.size.width
                let height = geo.size.height
                ZStack{
                    Color
                        .gray.opacity(0.3)
                        .ignoresSafeArea()
                    
                    //  캘린더
                    VStack{
                        Spacer().frame(height: 10)
                        ZStack{
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.white)
                                .padding(.horizontal,16)
                                .overlay(UICalendarView(pageCurrent: $viewModel.currentPage, titleText: $viewModel.titleText).padding(10).padding(.horizontal,16))
                        }
                        Spacer().frame(height: height*0.545201668984701)
                    }

                    if showblind{
                        Color.black.opacity(0.4).ignoresSafeArea().transition(AnyTransition.opacity.animation(.linear(duration: 0.15)))
                            .onTapGesture {
                                withAnimation() {
                                    showblind = false
                                }
                            }
                    }
                    AnimatedExpandableButton(isShowGray: self.$showblind)
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(Text(TitleString))
                
                //  상단 툴바
                .toolbar {
                    
                    //  네비게이션 왼쪽
                    ToolbarItem(placement: .navigationBarLeading) {
                        
                        //  상단 다음달 버튼
                        Button{
                            viewModel.currentPage = Calendar.current.date(byAdding: .month, value: -1, to: viewModel.currentPage)!
                        }label: {
                            ZStack{
                                HStack{
                                    Image(systemName: "chevron.backward")
                                        .foregroundColor(showblind ? .black.opacity(0.4) : .blue)
                                    Text("이전 달")
                                        .foregroundColor(showblind ? .black.opacity(0.4) : .blue)
                                }
                            }
                        }
                        .disabled(showblind)
                    }
                    
                    //  네비게이션 오른쪽
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button{
                            viewModel.currentPage = Calendar.current.date(byAdding: .month, value: +1, to: viewModel.currentPage)!
                        }label: {
                            ZStack{
                                HStack{
                                    Text("다음 달")
                                        .foregroundColor(showblind ? .black.opacity(0.4) : .blue)
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(showblind ? .black.opacity(0.4) : .blue)
                                }
                            }
                        }
                        .disabled(showblind)
                    }
                }

            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}

//  캘린더 뷰
struct UICalendarView : UIViewRepresentable{
    
    //  CalendarViewModel에 양도될 Binding 변수
    @Binding var pageCurrent: Date
    @Binding var titleText: Date
    
    func makeUIView(context: Context) -> FSCalendar {
        let calendar = FSCalendar()
        //  한국어 변경
        calendar.locale = Locale(identifier: "ko_KR")
        
        //  상단 표시 변경
        calendar.headerHeight = 0
        
        //  상단 표시 폰트 크기
        calendar.appearance.weekdayFont = .systemFont(ofSize: 18)
        
        //  날짜 폰트 크기
        calendar.appearance.titleFont = .systemFont(ofSize: 20)
        
        
        //  상단 일 크기
        calendar.weekdayHeight = 32
        
        //  마지막만 표시하기
        calendar.placeholderType = .fillHeadTail
        calendar.appearance.eventOffset.y = 5
        
        calendar.delegate = context.coordinator
        calendar.dataSource = context.coordinator
        
        return calendar
    }
    
    //  뷰 업데이트 함수
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.setCurrentPage(pageCurrent, animated: true)
    }
    func makeCoordinator() -> UICalendarView.Coordinator {
        
        //  스스로를 연결
        return Coordinator(calendar:self)
    }
    
    class Coordinator : NSObject, FSCalendarDataSource, FSCalendarDelegate, FSCalendarDelegateAppearance {
        
        //  만들어지는 Fscalendar
        var calendar : UICalendarView
        
        init(calendar: UICalendarView){
            self.calendar = calendar
        }
        
        //    이벤트처리
        func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
            return 1
        }
        
        func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
            return [.black]
        }
        
        //  데이트 페이지, 현재 페이지 공유
        func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
            self.calendar.pageCurrent = calendar.currentPage
            self.calendar.titleText = calendar.currentPage
        }
    }
}
//  CalendarView에서 다루는 Date의 델리게이트 역할 수행
class CalendarViewModel : NSObject,ObservableObject{
    @Published var currentPage : Date = Date()
    @Published var titleText : Date = Date()
    @Published var selectedDate = ""
}
extension CalendarViewModel{

    func dateSelected(_ date: Date) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            self.selectedDate = date.description
        }
    }
}
