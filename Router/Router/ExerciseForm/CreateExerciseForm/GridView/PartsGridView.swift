//
//  PartsGridView.swift
//  Router
//
//  Created by KimWooJin on 2022/12/20.
//

import SwiftUI

struct PartsGridView: View {
    @State var colorArray: [Color?] = [.red, .yellow, .gray, .black]
    var colorRows: [GridItem] = .init(repeating: GridItem(.flexible(),spacing: 10), count: 1)
    var body: some View {
        LazyHGrid(rows: colorRows,alignment: .firstTextBaseline) {
            ForEach($colorArray, id: \.self) { color in
                Text("")
                    .modifier(BackRoundedRecModifier(cornerValue: 8))
            }
            .scaledToFill()
        }
        .frame(height: 50)
        .frame(width: UIScreen.main.bounds.width)
        .border(.black, width: 5)
        
    }
}

struct PartsGridView_Previews: PreviewProvider {
    static var previews: some View {
        PartsGridView()
    }
}
