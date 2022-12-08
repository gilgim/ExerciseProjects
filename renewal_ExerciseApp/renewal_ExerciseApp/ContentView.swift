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
                utilPrint(title: "URL") {
                    if let realmUrl = Realm.Configuration.defaultConfiguration.fileURL {
                        print("RealmFileURL : \(realmUrl)")
                    }
                    else {
                        print("Can't find realm url.")
                    }
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
