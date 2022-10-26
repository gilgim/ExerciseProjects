//
//  CreateExerciseViewModel.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/10/24.
//

import Foundation

class CreateExerciseViewModel: ObservableObject {
    //  ================================ < Variable > ================================
    /// Creating Exercise Name
    @Published var name: String = ""
    
    /// Creating Exercise Explain
    @Published var explain: String?
    
    /// Creating Exercise Youtube link
    @Published var link: String?
    
    /// Creating Exercise Selected part
    @Published var parts: String = ""
    
    /// Creating Exercise Equiment
    @Published var equiment: String = ""
    
    /// Creating Exercise Equiment
    @Published var bookmakr: Bool = false
    /*
        Detail part is make of Realm data.
        So, I will make function that change realm data to struct data
     */
    /// Creating Exercise Seleted detail part
    @Published var detailPart: String = ""
}
