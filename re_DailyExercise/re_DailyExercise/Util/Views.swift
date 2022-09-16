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
    init(title: String ,@ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(title)
                    .font(.system(size: 25, weight: .black, design: .rounded))
                    .padding(.bottom,5)
                    .padding(.leading,16)
                Spacer()
            }
            ZStack {
                content().padding(.horizontal,16)
            }
        }
        .padding(.vertical,10)
    }
}
struct ContentIndexView<Content>: View where Content: View {
    @Binding var wholeIsSelect: Bool
    @Binding var selectObject: Bool
    @State var wholeX: CGFloat = 0
    @State var x: CGFloat = 0
    let backColor: Color
    let corner: CGFloat
    let content: ()->Content
    let action: ()->()
    init(_ backColor: Color, corner: CGFloat,
         wholeIsSelect: Binding<Bool>, selectObject: Binding<Bool>,
         action: @escaping()->(),
        @ViewBuilder content: @escaping () -> Content) {
        self.corner = corner
        self.backColor = backColor
        self.action = action
        self._wholeIsSelect = wholeIsSelect
        self._selectObject = selectObject
        self.content = content
    }
    var body: some View {
        HStack {
            if wholeIsSelect {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.blue)
                    .opacity(selectObject ? 1:0)
                    .overlay {
                        Circle().stroke(selectObject ? .blue:.black, lineWidth: 1)
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
                RoundedRecView(backColor,cornerValue: corner) {
                    content()
                }
                .offset(x:x)
                .gesture(DragGesture().onChanged({ value in
                    withAnimation {
                        if !wholeIsSelect {
                            if value.translation.width < -50 {
                                x = -50
                            }
                            else {
                                x = 0
                            }
                        }
                    }
                }))
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
    var array: Array<String>
    var gridColumns: Array<GridItem> {
        Array(repeating: GridItem(spacing: 8), count: 5)
    }
    init(_ array: Array<String> = [],userData: Binding<Array<String>>) {
        self.array = array
        self._userData = userData
    }
    var body: some View {
        LazyVGrid(columns: gridColumns) {
            ForEach(array, id: \.self){ text in
                Button {
                    Util.bindingArrayAppend(&userData, value: text)
                }label: {
                    Text(text)
                }
                .buttonStyle(GridButtonStyle(.black,.purple,userArray: _userData,text: text))
            }
        }
    }
}

struct GridButtonStyle: ButtonStyle{
    @Binding var userArray: [String]
    var text: String
    var foreColor: Color
    var backColor: Color
    var buttonCorner: CGFloat
    init(_ foreColor: Color,_ backColor: Color,_ buttonCorner: CGFloat = 0,
         userArray: Binding<Array<String>>, text: String) {
        self.foreColor = foreColor
        self.backColor = backColor
        self.buttonCorner = buttonCorner
        self.text = text
        self._userArray = userArray
    }
    func makeBody(configuration: Configuration) -> some View {
        RoundedRecView(backColor, cornerValue: 13, strokeColor: foreColor, strokeLine: 3) {
            configuration.label
                .padding()
                .foregroundColor(foreColor)
                
        }
        .opacity(userArray.contains(text) ? 1 : 0.75)
        .animation(.linear(duration: 0.1), value: configuration.isPressed)
        
    }
}

struct SearchBar: View {
    @Binding var backColor: Color
    @Binding var text: String
    let action: ()->()
    init(_ backColor: Binding<Color> = .constant(.gray.opacity(0.4)),text: Binding<String>, action: @escaping () -> Void) {
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
        .padding(.horizontal)
        .frame(height: 36)
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
