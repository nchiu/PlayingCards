//
//  Suit+SwiftUI.swift
//  
//
//  Created by Nathan Chiu on 6/19/23.
//

import SwiftUI

extension Deck.Card.Suit {
	/// SF Symbol representing the suit
	/// - Parameter filled: If `true` the filled variant of the symbol will be used. Optional, defaults to `true`
	/// - Returns: SF Symbol representing the suit
	func icon(filled: Bool = true) -> Image {
		var suitName = ""
		switch self  {
		case .club: suitName = "club"
		case .diamond: suitName = "diamond"
		case .heart: suitName = "heart"
		case .spade: suitName = "spade"
		}
		return .init(systemName: "suit.\(suitName)\(filled ? ".fill" : "")")
	}
}
