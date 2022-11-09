//
//  ContentView.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/10/24.
//

import SwiftUI
import RealmSwift

struct ContentView: View {
    var body: some View {
        ExerciseMainView()
            .onAppear() {
                print("========== < URL > ==========")
                print("RealmFileURL : \(Realm.Configuration.defaultConfiguration.fileURL)")
                print("=============================")
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
