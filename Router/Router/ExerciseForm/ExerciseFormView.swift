//
//  ExerciseFormView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/19.
//

import SwiftUI

struct ExerciseFormView: View {
    //  ===== User Inputs =====
    /// 유저가 검색바에서 사용하는 String 입니다. "" 일 경우 모든 경우가 호출됩니다.
    @State var searchText = ""
    /// 유저가 검색바에서 선택하는 대근육의 부위로 선택을 안했을 시 모든 경우가 호출됩니다.
    @State var userSelectPart: BodyPart?
    /// 유저가 선택하는 운동을 다루기 위한 배열입니다. 팝업 시에만 값을 할당합니다.
    @Binding var selectedExercises: [ExerciseFormStruct]
    
    //  ===== About View =====
    /// 상단 "+" 버튼 클릭 시 CreateView를 호출하는 Bool 값 입니다.
    @State var isCreateExercise: Bool = false
    /// 현재 ExerciseFormView가 Pop되었을 시 상태를 나타내는 Bool 값 입니다.
    @Binding var isPop: Bool
    
    @StateObject var exerciseVm = ExerciseFormViewModel()
    /**
     다른 뷰에 의해서 팝업 되었을 시에만 할당되는 Initailize   입니다.
     
     - parameters:
        -   selectedExercises: 사용자가 선택할 운동이 추가되는 바인딩 배열입니다. 호출하지 않은 곳에서는 빈 배열이 할당됩니다.
        -   isPop: 다른 뷰에서 호출 시 true 값이 기댓값이며 dismiss 시에는 false 값이 기댓값입니다.
     */
    init(selectedExercises: Binding<[ExerciseFormStruct]> = .constant([]), isPop: Binding<Bool> = .constant(false)) {
        self._selectedExercises = selectedExercises
        self._isPop = isPop
    }
    var body: some View {
        NavigationView {
            VStack {
                SearchView(text: $searchText, array: BodyPart.allCases, component: $userSelectPart)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .font(.system(size: 15))
                    .padding(.horizontal, 10)
                List {
                    ForEach(self.exerciseVm.exerciseArray, id: \.name) { exercise in
                        //  기존에 이렇게 작성하기 싫었지만 클로져 내에서 if 문이 플로우의 흐름을 바꾸지 못한다는 것 같은데 수정할 수 있으면 하는게 좋을 것 같습니다.
                        //  검색바가 비어 있거나 검색 시 사용자가 입력한 값이 나와 있으면 무조건 호출되는 if 입니다.
                        if self.searchText == "" || (exercise.name).contains(searchText) {
                            
                            //  검색바 밑 버튼이 클릭되어 있지 않으면 모든 컨텐츠를 아닐 경우 해당 값만 호출되게 하는 if 입니다.
                            if self.userSelectPart == nil || exercise.parts.contains(where: {$0 == self.userSelectPart}) {
                                Button {
                                    //  다른 뷰에서 호출되었을 때 클릭된 요소를 추가하기 위한 if 입니다. 재 클릭 시 취소할 수 있습니다.
                                    if self.isPop {
                                        if !selectedExercises.contains(exercise) {
                                            selectedExercises.append(exercise)
                                        }
                                        else {
                                            selectedExercises = selectedExercises.filter({$0 != exercise})
                                        }
                                    }
                                    //  FIXME: ExerciseFormView 내에서 버튼을 클릭 시에 설명 및 세부사항 변경 뷰를 호출하기 위한 if가 추가되어야 합니다.
                                }label: {
                                    HStack {
                                        //  MARK: Icon - 해당 운동의 아이콘을 나타냅니다.
                                        Circle()
                                            .modifier(
                                                CustomCircleModifier(color: .init(hex: exercise.imageColorName),iconName: exercise.imageName, 12, lineWidth: 2)
                                            )
                                        //  MARK: 운동 사항 - 부위, 기구, 이름을 혼합한 뷰 입니다.
                                        VStack(alignment: .leading) {
                                            //  운동 부위를 나타냅니다. 부위가 많을 시 혼합으로 표출합니다.
                                            Text(exercise.parts.count == 1 ? exercise.parts[0].rawValue : "혼합")
                                                .fontWeight(.light)
                                                .foregroundColor(.gray)
                                            
                                            //  운동 이름을 나타냅니다.
                                            Text(exercise.name)
                                                .font(.system(size: 25))
                                            
                                            //  FIXME: 왼쪽 하단의 어떠한 요소(세부부위 개수?, 기구?)가 추가될 예정입니다.
                                        }
                                        .padding(.leading, 10)
                                        Spacer()
                                    }
                                    .frame(height: 50)
                                    .modifier(
                                        BackRoundedRecModifier(cornerValue: 10,
                                                               isSelect: self.isPop ? .constant(self.selectedExercises.contains(where: {$0 == exercise})):.constant(false))
                                    )
                                }
                                .padding(.vertical, 5)
                                .padding(.horizontal, 10)
                                .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                                .listRowSeparator(.hidden)
                            }
                        }
                    }
                }
                .listStyle(InsetListStyle())
            }
            //  MARK: Self Navigation
            //  다른 뷰에서 팝 되었을 때를 제외하고는 해당 navigation은 숨겨집니다.
            .navigationBarHidden(!isPop)
            .navigationTitle("선택하기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        //  X 버튼을 클릭 시 선택했던 모든 값을 지우고 뷰를 dismiss 합니다.
                        self.selectedExercises = []
                        self.isPop.toggle()
                    }label: {
                        Image(systemName: "xmark")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        //  완료 버튼을 클릭 시 뷰를 dismiss 합니다. 상위 뷰에 클릭한 요소는 상위뷰에서 처리됩니다.
                        self.isPop.toggle()
                    }label: {
                        //  개수가 없을 시 "개"의 대한 hidden을 구현합니다.
                        Text(selectedExercises.count != 0 ? "\(selectedExercises.count)개":"" + "선택완료")
                    }
                    //  개수가 없을 시 버튼사용을 금지합니다.
                    .disabled(selectedExercises.count == 0)
                }
            }
        }
        //  MARK: View Appear
        .onAppear() {
            self.exerciseVm.viewAppearAction()
        }
        //  MARK: Stack Navigation
        //  navigation stack에 push 되었을 때 할당되는 navigation 특성입니다.
        .navigationTitle("운동 목록")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    //  "+" 버튼 클릭 시 운동을 생성하는 뷰를 호출합니다.
                    self.isCreateExercise.toggle()
                }label: {
                    Image(systemName: "plus")
                }
            }
        }
        .navigationDestination(isPresented: $isCreateExercise) {
            CreateExerciseFormView()
        }
    }
}

struct ExerciseFormView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseFormView()
    }
}
