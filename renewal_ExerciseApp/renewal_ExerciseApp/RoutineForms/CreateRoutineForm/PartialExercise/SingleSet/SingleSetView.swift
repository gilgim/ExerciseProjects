//
//  SingleSetView.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/12/10.
//

import SwiftUI

struct SingleSetView: View {
	@State var image: Image
    @GestureState var ges = false
	var body: some View {
		Circle()
			.frame(width: 100)
			.foregroundColor(.brown)
			.overlay {
				image
					.resizable()
					.scaledToFit()
					.padding(.vertical, 10)
                    .clipShape(Circle())
					.frame(maxWidth: .infinity)
					.foregroundColor(.white)
			}
	}
}

struct SingleSetView_Previews: PreviewProvider {
    static var previews: some View {
		SingleSetView(image: .init(systemName: "questionmark"))
    }
}
