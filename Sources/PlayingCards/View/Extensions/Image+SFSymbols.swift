//
//  Image+SFSymbols.swift
//  
//
//  Created by Nathan Chiu on 6/22/23.
//

import SwiftUI

extension Image {
	init(sfSymbol: SFSymbol) {
		self.init(systemName: sfSymbol.rawValue)
	}

	enum SFSymbol: String, CaseIterable {
		case crown = "crown"
		case crownFill = "crown.fill"
		case partyPopper = "party.popper"
		case questionMarkSquareDashed = "questionmark.square.dashed"
		case theaterMasks = "theatermasks"
	}
}

// MARK: Preview Provider
struct SFSymbol_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			ForEach(Image.SFSymbol.allCases, id: \.self) {
				Image(sfSymbol: $0)
			}
		}
	}
}
