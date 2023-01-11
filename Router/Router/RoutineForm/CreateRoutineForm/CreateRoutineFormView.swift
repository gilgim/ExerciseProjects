//
//  CreateRoutineFormView.swift
//  Router
//
//  Created by KimWooJin on 2023/01/03.
//

import SwiftUI

struct CreateRoutineFormView: View {
    @StateObject var createVm = CreateRoutineFormViewModel()
    /// 리스트에서 사용될 부분 뷰 입니다.
    @State var partialViews: [RoutinePartialView] = []
    var body: some View {
        VStack {
            List {
                Group {
                    ForEach(partialViews, id:\.int) { view in
                        view
                    }
                    .onMove { from, to in
                        //  리스트를 드래그하여 순서를 바꿀 시 ForEach의 View도 같이 바꿔주기 위한 로직입니다.
                        self.createVm.sequence.move(fromOffsets: from, toOffset: to)
                        print(createVm.sequence)
                    }
                    .swipeActions {
                        Button("test") {
                            
                        }
                    }
                    Button("plus") {
                        //  하위뷰가 들고 있는 id 값입니다.
                        //  추후 저장할 때 배열 내의 id 위치에 따라서 루틴 순서가 정해집니다.
                        //  [3,4,1] 이라면 id가 3인 부분이 첫 번째 항목이 됩니다.
                        let id = self.createVm.sequence.count
                        self.createVm.partialArray.append([])
                        self.partialViews.append(RoutinePartialView(int: id, setArray: $createVm.partialArray[id]))
                        self.createVm.sequence.append(createVm.sequence.count)
                    }
                    .modifier(BackRoundedRecModifier(cornerValue: 12))
                    .frame(height: 100)
                }
                .listRowInsets(.init(top: 5, leading: 10, bottom: 5, trailing: 10))
                .listRowSeparator(.hidden)
            }
            .listStyle(InsetListStyle())
        }
        .onChange(of: self.createVm.sequence) { newValue in
            //  루틴 순서를 넣어 재배열을 담당할 임시 뷰 저장소 입니다.
            var temp: [RoutinePartialView] = []
            for i in 0..<partialViews.count {
                let id = self.createVm.sequence[i]
                temp.append(partialViews.filter({$0.int == id})[0])
            }
            self.partialViews = temp
        }
    }
}

struct CreateRoutineFormView_Previews: PreviewProvider {
    static var previews: some View {
        CreateRoutineFormView()
    }
}
