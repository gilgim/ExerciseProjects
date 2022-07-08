//
//  Util.swift
//  RecordingExcerCise
//
//  Created by KimWooJin on 2022/06/20.
//

import Foundation
import SwiftUI

struct Util{
    public static func encodingJson(){
        
    }
    public static func decodingJson(){
        
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
