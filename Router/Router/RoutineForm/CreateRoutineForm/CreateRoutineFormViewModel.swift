//
//  CreateRoutineFormViewModel.swift
//  Router
//
//  Created by KimWooJin on 2023/01/03.
//

import Foundation
import Combine

class CreateRoutineFormViewModel: ObservableObject {
    @Published var partialArray: [[RoutineComponentType]] = []
    var sequence: [Int] = []
}
