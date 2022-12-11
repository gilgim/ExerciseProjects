//
//  SingleSetView.swift
//  renewal_ExerciseApp
//
//  Created by KimWooJin on 2022/12/10.
//

import SwiftUI

struct SingleSetView: View {
	@State var image: Image
	var body: some View {
		Circle()
			.frame(width: 100)
			.foregroundColor(.brown)
			.overlay {
				image
					.resizable()
					.scaledToFit()
					.padding(.vertical, 10)
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