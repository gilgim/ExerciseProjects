//
//  SingleSetView.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/12/09.
//

import Foundation
import SwiftUI

/// SingleSet contain some exercise contents.
struct PartialExerciseView: View {
    //  ================================ < About View Variable > ================================
    /// This variable explain what SingleSetView is contained.
	@State var partialExNumber: Int
    @State var setArray: [SingleSetStruct] = []
    @State var isShowExerciseForm = false
    @State var sheetClickEvent = false
    //  ================================ < About ViewModel > ================================
    @StateObject var partialVM = PartialExerciseViewModel()
    //  ================================ < Input Variable > ================================
    @State var selectComponentForm: ExerciseFormStruct?
    @State var selectedSet: SingleSetStruct?
    static var currentDragingPartial: Int = 0
    var body: some View {
        //  MARK: Partial Exercise ScrollView
        ScrollView(.horizontal, showsIndicators: false) {
			HStack {
                ForEach(self.setArray, id: \.id) { singleSet in
                    //  MARK: SingleSetView contain image ...
                    SingleSetView(image: singleSet.uiImage == nil ?
                                  Image(systemName: singleSet.imageName!):
                                  Image(uiImage: singleSet.uiImage!))
                        //  ===== <Drag & Drop> =====
                        .onDrag {
                            //  Allocating selected Contents.
                            print("onDrag count \(singleSet.particalSequence)")
                            self.selectedSet = singleSet
                            PartialExerciseView.currentDragingPartial = singleSet.particalSequence
                            return NSItemProvider(item: nil, typeIdentifier: singleSet.exerciseName ?? "Not Component")
                        }
                        //  If partialSequence of draging content same partialSequence of content
                        .onDrop(of: [singleSet.exerciseName ?? "Not Component"],
                                delegate: SingleSetDropDelegate(list: $setArray, target: $selectedSet, selected: singleSet)
                        )
				}
                //  MARK: Add Single Set Button
				Button {
					self.isShowExerciseForm = true
				}label: {
					SingleSetView(image: .init(systemName: "plus"))
				}
			}
        }
        //  ========== Sheet & Alert ==========
        .sheet(isPresented: $isShowExerciseForm, onDismiss: {
            if sheetClickEvent {
                self.setArray = partialVM.dismissExerciseFormView(array: self.setArray, sequence: self.partialExNumber, object: self.selectComponentForm)
            }
            self.sheetClickEvent = false
        }) {
            ExerciseFormView(exerciseForm: $selectComponentForm, isShow: .constant(true), clickEvent: $sheetClickEvent)
		}
    }
}

//  Drag Delegate about Content in SingleSet
struct SingleSetDropDelegate: DropDelegate {
    //  ================================ < Input Variable > ================================
    @Binding var list: [SingleSetStruct]
    @Binding var target: SingleSetStruct?
    var selected: SingleSetStruct?
    init(list: Binding<[SingleSetStruct]> = .constant([]), target: Binding<SingleSetStruct?> = .constant(nil), selected: SingleSetStruct? = nil) {
        self._list = list
        self._target = target
        self.selected = selected
    }
    func performDrop(info: DropInfo) -> Bool {
        true
    }
    func dropUpdated(info: DropInfo) -> DropProposal? {
        guard target?.particalSequence == PartialExerciseView.currentDragingPartial else {return DropProposal(operation: .forbidden)}
        return DropProposal(operation: .move)
    }
    func dropEntered(info: DropInfo) {
        guard let selected else {return}
        guard let target else {return}
        guard target.particalSequence == PartialExerciseView.currentDragingPartial else {return}
        //  Component is selected by user
        let to = list.firstIndex(of: selected)!
        // A place where user finger pass by
        let from = list.firstIndex(of: target)!
        //  Content is moved this logic
        withAnimation {
            self.list.move(fromOffsets: IndexSet(integer: from), toOffset: to > from ? to + 1 : to)
            utilPrint(title: "Move List") {
                print(list.map({$0.exerciseName}))
            }
        }
    }
}
