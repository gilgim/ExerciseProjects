//
//  Views.swift
//  re_DailyExercise
//
//  Created by KimWooJin on 2022/08/29.
//

import Foundation
import SwiftUI

// MARK: -Views
/**
 SafeArea 색상을 지정 가능한 뷰
 */
struct SafeVStack<Content>: View where Content: View {
    let content: () -> Content
    let topColor: Color
    let mainColor: Color
    let bottomColor: Color
    
    init(_ colors:[Color] = [.clear,.clear,.clear]
         ,@ViewBuilder content: @escaping () -> Content) {
        self.topColor = colors[0]
        self.mainColor = colors[1]
        self.bottomColor = colors[2]
        self.content = content
    }
    var body: some View {
        ZStack {
            topColor.edgesIgnoringSafeArea(.top)
            bottomColor.edgesIgnoringSafeArea(.bottom)
            ZStack {
                mainColor
                VStack(spacing:0) {
                    content()
                }
            }
        }
    }
}

struct ItemZstack<Content>: View where Content: View {
    let content: () -> Content
    let tag: Int
    let tagImage: String
    let tagText: String
    init(tag: Int = 0, tagImage: String = "", tagText: String = "",
         @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.tag = tag
        self.tagImage = tagImage
        self.tagText = tagText
    }
    var body: some View {
        NavigationView {
            ZStack{
                content()
            }
        }.tabItem{
            Text(tagText)
            Image(systemName: tagImage)
        }.tag(tag)
    }
}

struct RoundedRecView<Content>: View where Content: View {
    let content: () -> Content
    let rectangleColor: Color
    let cornerValue: CGFloat
    let strokeColor: Color
    let strokeLine: CGFloat
    init(_ rectangleColor: Color, cornerValue: CGFloat,
         strokeColor: Color = .clear, strokeLine: CGFloat = 0,
         @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.rectangleColor = rectangleColor
        self.cornerValue = cornerValue
        self.strokeLine = strokeLine
        self.strokeColor = strokeColor
    }
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: cornerValue)
                .stroke(strokeColor,lineWidth: strokeLine)
                .background(RoundedRectangle(cornerRadius: cornerValue).foregroundColor(rectangleColor))
            content()
        }
    }
}
struct TitleView<Content>: View where Content: View {
    let title: String
    let content: ()->Content
    let isPadding: Bool
    init(isPadding: Bool = true, title: String ,@ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
        self.isPadding = isPadding
    }
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(title)
                    .font(.system(size: AboutSize.deviceSize[1]*0.025, weight: .semibold, design: .rounded))
                    .padding(.bottom,5)
                    .padding(.leading,16)
                Spacer()
            }
            ZStack {
                content().padding(.horizontal, isPadding ? 16:0)
            }
        }
        .padding(.vertical,AboutSize.deviceSize[1]*0.012)
    }
}
struct ContentIndexView<Content>: View where Content: View {
    @Binding var wholeIsSelect: Bool
    @Binding var selectObject: Bool
    @State var wholeX: CGFloat = 0
    @State var x: CGFloat = 0
    @State var buttonState: CGFloat = 0
    let backColor: Color
    let corner: CGFloat
    let strokeColor: Color
    let strokeLine: CGFloat
    let content: ()->Content
    let action: ()->()
    init(_ backColor: Color, corner: CGFloat,
         strokeColor: Color = .clear, strokeLine: CGFloat = 0,
         wholeIsSelect: Binding<Bool>, selectObject: Binding<Bool>,
         action: @escaping()->(),
        @ViewBuilder content: @escaping () -> Content) {
        self.corner = corner
        self.backColor = backColor
        self.strokeColor = strokeColor
        self.strokeLine = strokeLine
        self.action = action
        self._wholeIsSelect = wholeIsSelect
        self._selectObject = selectObject
        self.content = content
    }
    var body: some View {
        HStack {
            if wholeIsSelect {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24)
                    .foregroundColor(.buttonSelectColor)
                    .opacity(selectObject ? 1:0)
                    .overlay {
                        Circle()
                            .stroke(Color.buttonSelectColor, lineWidth: 1.5)
                    }
                    .animation(.linear(duration: 0.1), value: selectObject)
            }
            ZStack {
                Color.red
                    .overlay(content: {
                        HStack {
                            Spacer()
                            Image(systemName: "trash.fill").foregroundColor(.white).padding()
                        }
                    })
                    .onTapGesture {
                        withAnimation {
                            action()
                            x = 0
                        }
                    }
                RoundedRecView(backColor,cornerValue: corner,strokeColor: strokeColor, strokeLine: strokeLine) {
                    content()
                }
                .offset(x:x)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            withAnimation {
                                if !wholeIsSelect {
                                    if buttonState == -50 {
                                        if value.translation.width > 0 && value.translation.width <= 50 {
                                            x = value.translation.width - 50
                                        }
                                    }
                                    else {
                                        if value.translation.width < 0 && value.translation.width >= -50 {
                                            x = value.translation.width
                                        }
                                    }
                                }
                            }
                        })
                        .onEnded({ value in
                            withAnimation {
                                if value.translation.width < 0 {
                                    x = -50
                                }
                                else {
                                    x = 0
                                }
                                self.buttonState = x
                            }
                        })
                )
            }
            .offset(x:wholeX)
            .cornerRadius(corner)
            .transition(.opacity)
        }
        .onChange(of: wholeIsSelect, perform: { _ in
            x = 0
        })
        .onAppear {
            x = 0
        }
    }
}
struct CustomLazyVGird: View {
    @Binding var userData: Array<String>
    @Binding var selectText: String
    var type: GridButtonStyle.GridType
    var array: Array<String>
    var gridColumns: Array<GridItem> {
        Array(repeating: GridItem(spacing: 8,alignment: .leading), count: type == .part ? 4:6)
    }
    init(_ array: Array<String> = [], type: GridButtonStyle.GridType,
         selectText :Binding<String> = .constant(""), userData: Binding<Array<String>> = .constant([])) {
        self.type = type
        self.array = array
        self._userData = userData
        self._selectText = selectText
    }
    var body: some View {
        LazyVGrid(columns: gridColumns) {
            ForEach(array, id: \.self){ text in
                Button {
                    if type == .part {
                        if selectText == text {
                            selectText = ""
                        }
                        else {
                            selectText = text
                        }
                    }
                    else {
                        Util.bindingArrayAppend(&userData, value: text)
                    }
                }label: {
                    Text(text)
                }
                .buttonStyle(GridButtonStyle(type, selectText: $selectText, userArray: _userData,text: text))
            }
        }
    }
}

struct GridButtonStyle: ButtonStyle{
    enum GridType {
        case part, equiment
    }
    @Binding var selectText: String
    @Binding var userArray: [String]
    var text: String
    var type: GridType
    init(_ type: GridType = .part,
         selectText: Binding<String> = .constant(""), userArray: Binding<Array<String>> = .constant([]),
         text: String) {
        self.type = type
        self._selectText = selectText
        self.text = text
        self._userArray = userArray
    }
    func compareText() -> Bool {
        if type == .part {
            return text == selectText
        }
        else {
            return userArray.contains(text)
        }
    }
    func makeBody(configuration: Configuration) -> some View {
        RoundedRecView(compareText() ? .buttonSelectBackColor:.white, cornerValue: 12,
                       strokeColor: compareText() ? .buttonSelectColor:.clear, strokeLine: 1.5) {
            configuration.label
                .foregroundColor(compareText() ? .buttonSelectColor:.buttonFontBlack)
                .padding(.horizontal, type == .part ? 20:12)
                .padding(.vertical,AboutSize.deviceSize[1]*0.012)
                .font(compareText() ? .system(size: AboutSize.deviceSize[1]*0.021,weight: .semibold):.system(size: AboutSize.deviceSize[1]*0.021,weight: .regular))
        }
        .animation(.linear(duration: 0.1), value: configuration.isPressed)
        .frame(width: type == .part ? 80:55, height: AboutSize.deviceSize[1]*0.055)
        .shadow(color: .almostShadowColor.opacity(0.2), radius: 4,y: 3)
    }
}

struct SearchBar: View {
    @Binding var backColor: Color
    @Binding var text: String
    let action: ()->()
    init(_ backColor: Binding<Color> = .constant(.searchBarColor),text: Binding<String>, action: @escaping () -> Void) {
        self._backColor = backColor
        self._text = text
        self.action = action
    }
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black.opacity(0.7))
                TextField("검색", text: $text)
                    .foregroundColor(.primary)
                    .onChange(of: text) { _ in
                        action()
                    }
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
            .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
            .foregroundColor(.secondary)
            .background(backColor)
            .cornerRadius(10.0)
        }
        .padding(.horizontal,16)
        .frame(height: AboutSize.deviceSize[1]*0.044)
    }
}

struct CustomListView<Content>: View where Content: View{
    let content: () -> Content
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    var body: some View {
        List {
            content()
            .listRowSeparator(.hidden)
            .listRowBackground(Rectangle().foregroundColor(.clear))
        }
        .listStyle(InsetListStyle())
    }
}
struct KeywordSearchView: View {
    var array: [String]
    @Binding var text: String
    var action: () -> ()
    init(array: [String], text: Binding<String>, action: @escaping () -> Void) {
        self.array = array
        self._text = text
        self.action = action
    }
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(array, id: \.self) { i in
                    Button {
                        if text == i {
                            text = ""
                        }
                        else {
                            text = i
                        }
                    }label: {
                        Text(i)
                    }
                    .buttonStyle(quickButtonStyle(text: i, selectText: $text))
                }
            }
            .padding(.vertical,AboutSize.deviceSize[1]*0.002)
            .padding(.horizontal,16)
        }
        .frame(height: AboutSize.deviceSize[1]*0.049)
        .onChange(of: text) { _ in
            action()
        }
    }
    struct quickButtonStyle: ButtonStyle {
        var text: String
        @Binding var selectText: String
        func makeBody(configuration: Configuration) -> some View {
            
            RoundedRecView(compareText() ? .buttonSelectBackColor:.white, cornerValue: 12,
                           strokeColor: compareText() ? .buttonSelectColor:.clear, strokeLine: 1.5) {
                configuration.label
                    .foregroundColor(compareText() ? .buttonSelectColor:.buttonFontBlack)
                    .padding(.horizontal, 20)
                    .padding(.vertical,AboutSize.deviceSize[1]*0.012)
                    .font(compareText() ? .system(size: AboutSize.deviceSize[1]*0.021,weight: .semibold):.system(size: AboutSize.deviceSize[1]*0.021,weight: .regular))
            }
            .shadow(color: .almostShadowColor.opacity(0.2), radius: 4,y: 3)

        }
        func compareText() -> Bool {
            return text == selectText
        }
    }
}

