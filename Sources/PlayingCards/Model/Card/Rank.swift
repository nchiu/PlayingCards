//
//  Rank.swift
//  
//
//  Created by Nathan Chiu on 6/19/23.
//

import Foundation

public extension Deck.Card {
	/// The rank of a playing card
	enum Rank: CaseIterable {
		case ace,
				 two,
				 three,
				 four,
				 five,
				 six,
				 seven,
				 eight,
				 nine,
				 ten,
				 jack,
				 queen,
				 king,
				 joker
	}
}

// MARK: Public
public extension Deck.Card.Rank {
	/// Numerical value of the rank.
	/// - Parameter aceIsHigh: If `true`, `ace` is valued higher than `king`, else `ace` is values lower than `two`. Optional, defaults to `false`.
	/// - Returns: `1` through `13` for `ace` through `king` respectively, or `2` through `14` for `two` through `ace` if `aceIsHigh` is `true`.
	func value(aceIsHigh: Bool = false) -> Int {
		switch self {
		case .ace: return aceIsHigh ? 14 : 1
		case .two: return 2
		case .three: return 3
		case .four: return 4
		case .five: return 5
		case .six: return 6
		case .seven: return 7
		case .eight: return 8
		case .nine: return 9
		case .ten: return 10
		case .jack: return 11
		case .queen: return 12
		case .king: return 13
		case .joker: return 15
		}
	}

	/// Returns `true` for jack, queen, king, and joker ranks, all else `false`
	var isFaceCard: Bool {
		switch self {
		case .ace, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten:
			return false
		case .jack, .queen, .king, .joker:
			return true
		}
	}

	/// The letter or number that represents the rank.
	var symbol: String {
		switch self {
		case .ace:
			return NSLocalizedString(
				"symbolAce",
				value: "A",
				comment: "abbreviated symbol for the rank of ace"
			)
		case .two:
			return NSLocalizedString(
				"symbolTwo",
				value: "2",
				comment: "abbreviated symbol for the rank of two"
			)
		case .three:
			return NSLocalizedString(
				"symbolThree",
				value: "3",
				comment: "abbreviated symbol for the rank of three"
			)
		case .four:
			return NSLocalizedString(
				"symbolFour",
				value: "4",
				comment: "abbreviated symbol for the rank of four"
			)
		case .five:
			return NSLocalizedString(
				"symbolFive",
				value: "5",
				comment: "abbreviated symbol for the rank of five"
			)
		case .six:
			return NSLocalizedString(
				"symbolSix",
				value: "6",
				comment: "abbreviated symbol for the rank of six"
			)
		case .seven:
			return NSLocalizedString(
				"symbolSeven",
				value: "7",
				comment: "abbreviated symbol for the rank of seven"
			)
		case .eight:
			return NSLocalizedString(
				"symbolEight",
				value: "8",
				comment: "abbreviated symbol for the rank of eight"
			)
		case .nine:
			return NSLocalizedString(
				"symbolNine",
				value: "9",
				comment: "abbreviated symbol for the rank of nine"
			)
		case .ten:
			return NSLocalizedString(
				"symbolTen",
				value: "10",
				comment: "abbreviated symbol for the rank of ten"
			)
		case .jack:
			return NSLocalizedString(
				"symbolJack",
				value: "J",
				comment: "abbreviated symbol for the rank of jack"
			)
		case .queen:
			return NSLocalizedString(
				"symbolQueen",
				value: "Q",
				comment: "abbreviated symbol for the rank of queen"
			)
		case .king:
			return NSLocalizedString(
				"symbolKing",
				value: "K",
				comment: "abbreviated symbol for the rank of king"
			)
		case .joker:
			return NSLocalizedString(
				"symbolJoker",
				value: "★",
				comment: "abbreviated symbol for the rank of king"
			)
		}
	}

	/// Localized descriptive string of the rank
	var description: String {
		switch self {
		case .ace:
			return NSLocalizedString(
				"rankAce",
				value: "ace",
				comment: "description for the rank of ace"
			)
		case .two:
			return NSLocalizedString(
				"rankTwo",
				value: "two",
				comment: "description for the rank of two"
			)
		case .three:
			return NSLocalizedString(
				"rankThree",
				value: "three",
				comment: "description for the rank of three"
			)
		case .four:
			return NSLocalizedString(
				"rankFour",
				value: "four",
				comment: "description for the rank of four"
			)
		case .five:
			return NSLocalizedString(
				"rankFive",
				value: "five",
				comment: "description for the rank of five"
			)
		case .six:
			return NSLocalizedString(
				"rankSix",
				value: "six",
				comment: "description for the rank of six"
			)
		case .seven:
			return NSLocalizedString(
				"rankSeven",
				value: "seven",
				comment: "description for the rank of seven"
			)
		case .eight:
			return NSLocalizedString(
				"rankEight",
				value: "eight",
				comment: "description for the rank of eight"
			)
		case .nine:
			return NSLocalizedString(
				"rankNine",
				value: "nine",
				comment: "description for the rank of nine"
			)
		case .ten:
			return NSLocalizedString(
				"rankTen",
				value: "ten",
				comment: "description for the rank of ten"
			)
		case .jack:
			return NSLocalizedString(
				"rankJack",
				value: "jack",
				comment: "description for the rank of jack"
			)
		case .queen:
			return NSLocalizedString(
				"rankQueen",
				value: "queen",
				comment: "description for the rank of queen"
			)
		case .king:
			return NSLocalizedString(
				"rankKing",
				value: "king",
				comment: "description for the rank of king"
			)
		case .joker:
			return NSLocalizedString(
				"rankJoker",
				value: "joker",
				comment: "description for the rank of joker"
			)
		}
	}
}

// MARK: Internal
extension Deck.Card.Rank {
	var pips: Int {
		guard !isFaceCard else { return 0 }
		return value(aceIsHigh: false)
	}
}

// MARK: Codable
extension Deck.Card.Rank: Codable { }

// MARK: - Private
private extension Deck.Card.Rank {
	
}
