//
//  SingleSetView.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/12/09.
//

import Foundation
import SwiftUI

/// SingleSet contain some exercise contents.
struct SingleSetView: View {
    //  ================================ < About View Variable > ================================
    /// This variable is this set id. this is used to make routine form.
    @State var setNumber: Int
    //  ================================ < About ViewModel > ================================
    @StateObject var singleVM = SingleSetViewModel()
    //  ================================ < Input Variable > ================================
    @State var selectedContent: ExerciseInRoutineSet?
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                if !(singleVM.exerciseAndRestArray.isEmpty) {
                    //  ===== About Content =====
                    ForEach(singleVM.exerciseAndRestArray, id: \.id) { content in
                        ContentInSetView(image: content.image)
                        //  About Size
                        .frame(height: 100)
                        //  About Drag
                        .onDrag {
                            //  A place where user finger pass by
                            self.selectedContent = content
                            return NSItemProvider(item: nil, typeIdentifier: content.id.description)
                        }
                        .onDrop(of: [content.id.description], delegate: SingleSetDropDelegate(seletedComponent: content, dataList: $singleVM.exerciseAndRestArray, targetComponent: $selectedContent))
                    }
                }
                // this button add component.
                Button {
                    singleVM.addComponentButtonAction()
                }label: {
                    Circle()
                        .foregroundColor(.brown)
                        .overlay {Image(systemName: "plus")}
                }
            }
            .onAppear() {
                singleVM.dummyData()
            }
        }
    }
}

//  Drag Delegate about Content in SingleSet
struct SingleSetDropDelegate: DropDelegate {
    //  ================================ < About View Variable > ================================
    /// User seleted item.
    let seletedComponent: ExerciseInRoutineSet
    //  ================================ < Input Variable > ================================
    @Binding var dataList: [ExerciseInRoutineSet]
    /// User will do move targetComponent place.
    @Binding var targetComponent: ExerciseInRoutineSet?
    
    // End Dragging
    func performDrop(info: DropInfo) -> Bool {
        return true
    }
    //  When selected component come into contact with another component
    func dropEntered(info: DropInfo) {
        guard let targetComponent else {return}
        if targetComponent != seletedComponent {
            //  Component is selected by user
            let to = dataList.firstIndex(of: seletedComponent)!
            // A place where user finger pass by
            let from = dataList.firstIndex(of: targetComponent)!
            //  Content is moved this logic
            withAnimation {
                self.dataList.move(fromOffsets: IndexSet(integer: from), toOffset: to > from ? to + 1 : to)
            }
        }
    }
}
struct ContentInSetView: View {
    @State var image: Image
    var body: some View {
        image
            .resizable()
            .scaledToFit()
    }
}
