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
	var partialExNumber: Int
    //  ================================ < About ViewModel > ================================

    //  ================================ < Input Variable > ================================
	@State var singleSetArray: [SingleSetStruct] = []
    @State var selectedSet: SingleSetStruct?
	@State var isShowExerciseForm = false
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
			HStack {
				ForEach(self.singleSetArray, id: \.id) { singleSet in
					SingleSetView(image: .init(systemName: singleSet.imageName ?? "questionmark"))
						.onDrag {
							self.selectedSet = singleSet
							return NSItemProvider(item: nil, typeIdentifier: singleSet.id.description)
						}
						.onDrop(of: [singleSet.id.description], delegate: SingleSetDropDelegate(selectedComponent: singleSet, targetComponent: $selectedSet, dataList: $singleSetArray))
				}
				Button {
					self.isShowExerciseForm = true
					singleSetArray.append(.init(particalExercise: partialExNumber, setType: .Rest))
				}label: {
					SingleSetView(image: .init(systemName: "plus"))
				}
			}
        }
		.onAppear() {
			self.singleSetArray = DummyData()
		}
		.sheet(isPresented: $isShowExerciseForm) {
			ExerciseFormView(isShow: .constant(true))
		}
    }
	func DummyData() -> [SingleSetStruct] {
		let one = SingleSetStruct(particalExercise: self.partialExNumber, setType: .Exercise, imageName: "figure.walk")
		let restOne = SingleSetStruct(particalExercise: self.partialExNumber, setType: .Rest)
		let two = SingleSetStruct(particalExercise: self.partialExNumber, setType: .Exercise, imageName: "figure.walk")
		let restTwo = SingleSetStruct(particalExercise: self.partialExNumber, setType: .Rest)
		let three = SingleSetStruct(particalExercise: self.partialExNumber, setType: .Exercise, imageName: "figure.walk")
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
        return true
    }
	func dropUpdated(info: DropInfo) -> DropProposal? {
		return DropProposal(operation: .move)
	}
	func validateDrop(info: DropInfo) -> Bool {
		if targetComponent?.particalExercise == selectedComponent.particalExercise {
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
