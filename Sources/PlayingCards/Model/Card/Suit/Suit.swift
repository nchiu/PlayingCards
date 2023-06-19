//
//  Suit.swift
//  
//
//  Created by Nathan Chiu on 6/19/23.
//

import Foundation

public extension Deck.Card {
	/// The categories of playing cards
	enum Suit: CaseIterable {
		case club,
				 diamond,
				 heart,
				 spade
	}
}

// MARK: Public
public extension Deck.Card.Suit {
	/// The color associated with the suit
	var color: Color {
		switch self {
		case .diamond, .heart: return .red
		case .club, .spade: return .black
		}
	}

	/// Unicode character representation of the suit, filled
	var pipFill: String {
		switch self {
		case .club: return "♣︎"
		case .diamond: return "♦︎"
		case .heart: return "♥︎"
		case .spade: return "♠︎"
		}
	}

	/// Unicode character representation of the suit, outlined
	var pipOutline: String {
		switch self {
		case .club: return "♧"
		case .diamond: return "♢"
		case .heart: return "♡"
		case .spade: return "♤"
		}
	}

	/// Localized descriptive string of the suit
	var description: String {
		switch self {
		case .club:
			return NSLocalizedString(
				"suitClubs",
				value: "clubs",
				comment: "description for the suit of clubs"
			)
		case .diamond:
			return NSLocalizedString(
				"suitDiamonds",
				value: "diamonds",
				comment: "description for the suit of diamonds"
			)
		case .heart:
			return NSLocalizedString(
				"suitHearts",
				value: "hearts",
				comment: "description for the suit of hearts"
			)
		case .spade:
			return NSLocalizedString(
				"suitSpades",
				value: "spades",
				comment: "description for the suit of spades"
			)
		}
	}
}

// MARK: Codable
extension Deck.Card.Suit: Codable { }

// MARK: - Private
private extension Deck.Card.Suit {
	
}
