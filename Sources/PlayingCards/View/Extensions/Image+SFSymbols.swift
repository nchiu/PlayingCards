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
		case questionMarkSquareDashed = "questionmark.square.dashed"
	}
}

struct SFSymbol_Previews: PreviewProvider {
	static var previews: some View {
		ForEach(Image.SFSymbol.allCases, id: \.self) {
			Image(sfSymbol: $0)
		}
	}
}
