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
    //  ================================ < About ViewModel > ================================
    @StateObject var partialVM = PartialExerciseViewModel()
    //  ================================ < Input Variable > ================================
    @State var selectComponentForm: ExerciseFormStruct?
    @State var selectedSet: SingleSetStruct?
	@State var isShowExerciseForm = false
    @State var sheetClickEvent = false
    @State var delegate: SingleSetDropDelegate?
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
			HStack {
                ForEach(self.setArray, id: \.id) { singleSet in
                    SingleSetView(image: singleSet.uiImage == nil ? Image(systemName: singleSet.imageName!):Image(uiImage: singleSet.uiImage!))
                        .onDrag {
                            self.selectedSet = singleSet
                            return NSItemProvider(item: nil, typeIdentifier: "\(singleSet.particalSequence)")
                        }
                        .onDrop(of: [singleSet.id.description], isTargeted: .constant(true)) { providers in
                            print("asdf")
                            return true
                        }
//                        .onDrop(of: ["\(singleSet.particalSequence)"], delegate: SingleSetDropDelegate(selectedComponent: singleSet, targetComponent: $selectedSet, dataList: $setArray))
				}
				Button {
					self.isShowExerciseForm = true
				}label: {
					SingleSetView(image: .init(systemName: "plus"))
				}
			}
        }
        .sheet(isPresented: $isShowExerciseForm, onDismiss: {
            if sheetClickEvent {
                partialVM.changeSelectComponentAction(setArray: &self.setArray, particalSequence: self.partialExNumber, selectedObject: self.selectComponentForm)
            }
        }) {
            ExerciseFormView(exerciseForm: $selectComponentForm, isShow: .constant(true), clickEvent: $sheetClickEvent)
		}
    }
	func DummyData() -> [SingleSetStruct] {
		let one = SingleSetStruct(particalSequence: self.partialExNumber, setType: .Exercise, imageName: "figure.walk")
		let restOne = SingleSetStruct(particalSequence: self.partialExNumber, setType: .Rest)
		let two = SingleSetStruct(particalSequence: self.partialExNumber, setType: .Exercise, imageName: "figure.walk")
		let restTwo = SingleSetStruct(particalSequence: self.partialExNumber, setType: .Rest)
		let three = SingleSetStruct(particalSequence: self.partialExNumber, setType: .Exercise, imageName: "figure.walk")
		return [one, restOne, two, restTwo, three]
	}
}

//  Drag Delegate about Content in SingleSet
struct SingleSetDropDelegate: DropDelegate {
    //  ================================ < About View Variable > ================================
    /// User seleted item.
    let selectedComponent: SingleSetStruct
    //  ================================ < Input Variable > ================================
	/// User will do move targetComponent place.
	@Binding var targetComponent: SingleSetStruct?
    @Binding var dataList: [SingleSetStruct]
    // End Dragging
    func performDrop(info: DropInfo) -> Bool {
        if targetComponent?.particalSequence == selectedComponent.particalSequence {
            return true
        }
        else {
            return false
        }
    }
	func dropUpdated(info: DropInfo) -> DropProposal? {
		return DropProposal(operation: .move)
	}
	func validateDrop(info: DropInfo) -> Bool {
		if targetComponent?.particalSequence == selectedComponent.particalSequence {
			return true
		}
		else {
			return false
		}
	}
    //  When selected component come into contact with another component
    func dropEntered(info: DropInfo) {
        guard let targetComponent else {return}
        if targetComponent != selectedComponent  {
            //  Component is selected by user
            let to = dataList.firstIndex(of: selectedComponent)!
            // A place where user finger pass by
            let from = dataList.firstIndex(of: targetComponent)!
            //  Content is moved this logic
            withAnimation {
                self.dataList.move(fromOffsets: IndexSet(integer: from), toOffset: to > from ? to + 1 : to)
            }
        }
    }
}
