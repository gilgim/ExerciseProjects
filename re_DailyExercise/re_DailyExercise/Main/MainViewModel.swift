//
//  MainViewModel.swift
//  re_DailyExercise
//
//  Created by KimWooJin on 2022/08/25.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var time: Timer?
    
    func startTime(closure: @escaping () -> ()) {
        time = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            closure()
        })
    }
    func stopTime() {
        time?.invalidate()
    }
}
