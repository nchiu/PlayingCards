//
//  Deck.swift
//  
//
//  Created by Nathan Chiu on 6/19/23.
//

import Foundation

public struct Deck: Identifiable {
	// MARK: Properties

	/// If `true`, `ace` is valued higher than `king`, else `ace` is values lower than `two`. Defaults to `false`.
	public var aceIsHigh: Bool {
		didSet {
			guard oldValue != aceIsHigh else { return }
			cards.indices.forEach { cards[$0].aceIsHigh = aceIsHigh }
		}
	}

	private var cards: [Card]

	// MARK: Initializers

	/// Creates a deck of playing cards. Each `card` representing a combination of `rank` (`ace` through `king`) and `suit` (`club`, `diamond`, `heart`, `spade`).
	/// - Parameters:
	///   - multiple: The number of times to repeat each card. `1` creates a 52 card deck with one of each card, `2` creates a 104 card deck with two of each card, and so on. Optional, defaults to `1`
	///   - aceIsHigh: If `true`, `ace` is valued higher than `king`, else `ace` is values lower than `two`. Optional, defaults to `false`.
	///   - includeJokers: If `true`, 2 joker cards will be included per multiple. Optional, defaults to `false`.
	public init(multiple: Int = 1, aceIsHigh: Bool = false, includeJokers: Bool = false) {
		self.aceIsHigh = aceIsHigh
		cards = (1...multiple).flatMap { _ in
			Card.Suit.allCases.flatMap { suit in
				Card.Rank.allCases.compactMap { rank in
					switch rank {
					case .ace, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .jack, .queen, .king:
						break
					case .joker:
						if includeJokers {
							switch suit {
							case .club, .diamond:
								return nil
							case .heart, .spade:
								break
							}
						} else {
							return nil
						}
					}
					return .init(
						rank: rank,
						suit: suit,
						aceIsHigh: aceIsHigh
					)
				}
			}
		}
	}

	// MARK: Identifiable
	public var id = UUID()
}

// MARK: Public
public extension Deck {

	/// The number of cards in the deck.
	var count: Int {
		cards.count
	}

	/// A `Bool` indicating whether the deck is empty.
	var isEmpty: Bool {
		cards.isEmpty
	}

	/// Removes a card from the deck
	/// - Returns: The card removed from the deck
	mutating func draw() -> Card? {
		guard !isEmpty else { return nil }
		return cards.removeLast()
	}

	/// Removes several cards from the deck
	/// - Returns: The cards removed from the deck
	mutating func draw(count: Int) -> [Card] {
		guard !isEmpty,
					count > 0
		else { return [] }

		return (1...min(count, self.count)).compactMap { _ in draw() }
	}

	/// Returns a card to the deck
	/// - Parameters:
	///   - card: The card to go into the deck
	///   - position: Where to insert the `card`in the deck
	mutating func bury(card: Card, at position: BuryPosition) {
		switch position {
		case .top:
			cards.append(card)
		case .middle:
			cards.insert(card, at: cards.indices.randomElement() ?? 0)
		case .bottom:
			cards.insert(card, at: 0)
		}
	}

	/// Returns an array of cards to the deck
	/// - Parameters:
	///   - cards: The cards to go into the deck
	///   - position: Where to insert the `cards`in the deck. If the position is `middle`, the cards will be split up and individually inserted at random positions, otherwise they will all be added consecutively to the `top` or `bottom` of the deck.
	mutating func bury(cards: [Card], at position: BuryPosition) {
		cards.forEach { bury(card: $0, at: position) }
	}

	/// Randomizes the order of the cards in the deck
	mutating func shuffle() {
		cards.shuffle()
	}

	/// Sorts the cards in the deck
	mutating func sort() {
		cards.sort {
			guard $0.value != $1.value else { return $0.suit.pipFill < $1.suit.pipFill }
			return $0.value < $1.value
		}
	}

	/// Observe all cards remaining in the deck.
	/// - Returns: All cards remaining in the deck
	func peak() -> [Card] {
		cards
	}

	/// Calculates the probability of drawing a card of a specific rank, suit, or both.
	/// - Parameters:
	///   - rank: The rank of interest
	///   - suit: The suit of interest
	/// - Returns: The percent chance (`0.0` through `1.0`) of the next card being of the specified `rank` and/or `suit`, `nil` if both `rank` and `suit` are `nil`
	func chanceOfDrawing(rank: Card.Rank?, suit: Card.Suit?) -> Double? {
		var matchingCards = [Card]()
		if let rank {
			if let suit {
				matchingCards = cards.filter { $0.rank == rank && $0.suit == suit }
			} else {
				matchingCards = cards.filter { $0.rank == rank }
			}
		} else if let suit {
			matchingCards = cards.filter { $0.suit == suit }
		} else {
			// neither a rank nor a suit is specified
			return nil
		}
		return Double(matchingCards.count) / Double(cards.count)
	}
}

public extension Deck {
	enum BuryPosition {
		case top
		case middle
		case bottom
	}
}

// MARK: Codable
extension Deck: Codable { }

// MARK: - Private
private extension Deck {

}
