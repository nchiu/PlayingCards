//
//  Card.swift
//  
//
//  Created by Nathan Chiu on 6/19/23.
//

import Foundation

public extension Deck {
	struct Card: Identifiable {

		// MARK: Properties

		/// The rank of the card
		public let rank: Rank

		/// The suit of the card
		public let suit: Suit

		/// If `true`, `ace` is valued higher than `king`, else `ace` is values lower than `two`. Defaults to `false`.
		public var aceIsHigh = false

		// MARK: Identifiable
		public var id = UUID()
	}
}

// MARK: Public
public extension Deck.Card {
	/// The value of the `rank`. `1` through `13` for `ace` through `king` respectively, or `2` through `14` for `two` through `ace` if `aceIsHigh` is `true`.
	var value: Int {
		rank.value(aceIsHigh: aceIsHigh)
	}

	var description: String {
		.init(
			format: NSLocalizedString(
				"cardRankSuitFormat",
				value: "%0@ of %1@",
				comment: "formatted description combining the rank (%0@) and suit (%1@), ex: 'ace of spades'"
			),
			rank.description,
			suit.description
		)
	}
}

// MARK: Equatable
extension Deck.Card: Equatable {
	public static func == (lhs: Self, rhs: Self) -> Bool {
		lhs.rank == rhs.rank
	}
}

// MARK: Comparable
extension Deck.Card: Comparable {
	public static func < (lhs: Deck.Card, rhs: Deck.Card) -> Bool {
		lhs.value < rhs.value
	}
}

// MARK: Codable
extension Deck.Card: Codable { }
