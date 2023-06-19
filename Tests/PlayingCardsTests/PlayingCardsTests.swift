import XCTest
@testable import PlayingCards

final class PlayingCardsTests: XCTestCase {
	private let defaultOrder = "♣︎1♣︎2♣︎3♣︎4♣︎5♣︎6♣︎7♣︎8♣︎9♣︎10♣︎11♣︎12♣︎13♦︎1♦︎2♦︎3♦︎4♦︎5♦︎6♦︎7♦︎8♦︎9♦︎10♦︎11♦︎12♦︎13♥︎1♥︎2♥︎3♥︎4♥︎5♥︎6♥︎7♥︎8♥︎9♥︎10♥︎11♥︎12♥︎13♠︎1♠︎2♠︎3♠︎4♠︎5♠︎6♠︎7♠︎8♠︎9♠︎10♠︎11♠︎12♠︎13"
	private let sortOrder = "♠︎1♣︎1♥︎1♦︎1♠︎2♣︎2♥︎2♦︎2♠︎3♣︎3♥︎3♦︎3♠︎4♣︎4♥︎4♦︎4♠︎5♣︎5♥︎5♦︎5♠︎6♣︎6♥︎6♦︎6♠︎7♣︎7♥︎7♦︎7♠︎8♣︎8♥︎8♦︎8♠︎9♣︎9♥︎9♦︎9♠︎10♣︎10♥︎10♦︎10♠︎11♣︎11♥︎11♦︎11♠︎12♣︎12♥︎12♦︎12♠︎13♣︎13♥︎13♦︎13"

	func testDeckDefaultInitialization() throws {
		var deck = Deck()
		XCTAssertEqual(deck.count, 52)
		XCTAssertEqual(deck.aceIsHigh, false)
		XCTAssertEqual(deck.isEmpty, false)
		XCTAssertEqual(stringRepresentation(of: deck), defaultOrder)
	}

	func testMultiDeckInitialization() throws {
		var deck = Deck(multiple: 2)
		XCTAssertEqual(deck.count, 104)
		XCTAssertEqual(deck.aceIsHigh, false)
		XCTAssertEqual(deck.isEmpty, false)
		XCTAssertEqual(stringRepresentation(of: deck), defaultOrder + defaultOrder)
	}

	func testAceHighDeckInitialization() throws {
		var deck = Deck(aceIsHigh: true)
		XCTAssertEqual(deck.count, 52)
		XCTAssertEqual(deck.aceIsHigh, true)
		XCTAssertEqual(deck.isEmpty, false)

		deck.sort()
		let aces = deck.draw(count: 4)
		XCTAssertEqual(aces.count, 4)
		aces.forEach {
			XCTAssertEqual($0.rank, .ace)
		}
	}

	func testSortOrder() {
		var deck = Deck()
		deck.sort()
		XCTAssertEqual(stringRepresentation(of: deck), sortOrder)
	}

	func testDraw() throws {
		var deck = Deck()
		var card: Deck.Card?
		deck.sort()

		card = deck.draw()
		XCTAssertEqual(card?.suit, .diamond)
		XCTAssertEqual(card?.rank, .king)

		card = deck.draw()
		XCTAssertEqual(card?.suit, .heart)
		XCTAssertEqual(card?.rank, .king)

		card = deck.draw()
		XCTAssertEqual(card?.suit, .club)
		XCTAssertEqual(card?.rank, .king)

		card = deck.draw()
		XCTAssertEqual(card?.suit, .spade)
		XCTAssertEqual(card?.rank, .king)

		XCTAssertEqual(deck.count, 48)
		_ = deck.draw(count: .max)
		card = deck.draw()
		XCTAssertEqual(card?.suit, nil)
		XCTAssertEqual(card?.rank, nil)
	}

	func testDrawCount() throws {
		var deck = Deck()
		var cards = [Deck.Card]()
		deck.sort()

		cards = deck.draw(count: -1)
		XCTAssertEqual(cards.count, 0)

		cards = deck.draw(count: 0)
		XCTAssertEqual(cards.count, 0)

		cards = deck.draw(count: 10)
		XCTAssertEqual(cards.count, 10)
		XCTAssertEqual(cards.first?.rank, .king)
		XCTAssertEqual(cards.first?.suit, .diamond)
		XCTAssertEqual(cards.last?.rank, .jack)
		XCTAssertEqual(cards.last?.suit, .heart)

		cards = deck.draw(count: .max)
		XCTAssertEqual(cards.count, 42)
		XCTAssertEqual(cards.first?.rank, .ace)
		XCTAssertEqual(cards.first?.suit, .spade)
		XCTAssertEqual(cards.last?.rank, .jack)
		XCTAssertEqual(cards.last?.suit, .club)
	}

	func testChanceOfDrawing() throws {
		var deck = Deck()
		XCTAssertEqual(deck.chanceOfDrawing(rank: .eight, suit: nil), 1 / 13)
		XCTAssertEqual(deck.chanceOfDrawing(rank: nil, suit: .diamond), 1 / 4)
		XCTAssertEqual(deck.chanceOfDrawing(rank: .ace, suit: .spade), 1 / 52)

		deck.sort()
		_ = deck.draw(count: 12) // remove all face cards
		XCTAssertEqual(deck.chanceOfDrawing(rank: .eight, suit: nil), 1 / 10)
		XCTAssertEqual(deck.chanceOfDrawing(rank: nil, suit: .diamond), 1 / 4)
		XCTAssertEqual(deck.chanceOfDrawing(rank: .ace, suit: .spade), 1 / 40)
		XCTAssertEqual(deck.chanceOfDrawing(rank: .queen, suit: nil), 0)
	}

	func testShuffle() throws {
		var deck = Deck()
		XCTAssertEqual(stringRepresentation(of: deck), defaultOrder)
		deck.shuffle()
		// 1 in 52 factorial chance that this could throw a false failure
		XCTAssertNotEqual(stringRepresentation(of: deck), defaultOrder)
	}

	func testColors() throws {
		XCTAssertEqual(Deck.Card(rank: .ace, suit: .club).suit.color, .black)
		XCTAssertEqual(Deck.Card(rank: .ace, suit: .spade).suit.color, .black)
		XCTAssertEqual(Deck.Card(rank: .ace, suit: .diamond).suit.color, .red)
		XCTAssertEqual(Deck.Card(rank: .ace, suit: .heart).suit.color, .red)
	}

	func testPipFill() throws {
		XCTAssertEqual(Deck.Card(rank: .ace, suit: .club).suit.pipFill, "♣︎")
		XCTAssertEqual(Deck.Card(rank: .ace, suit: .spade).suit.pipFill, "♠︎")
		XCTAssertEqual(Deck.Card(rank: .ace, suit: .diamond).suit.pipFill, "♦︎")
		XCTAssertEqual(Deck.Card(rank: .ace, suit: .heart).suit.pipFill, "♥︎")
	}

	func testPipOutline() throws {
		XCTAssertEqual(Deck.Card(rank: .ace, suit: .club).suit.pipOutline, "♧")
		XCTAssertEqual(Deck.Card(rank: .ace, suit: .spade).suit.pipOutline, "♤")
		XCTAssertEqual(Deck.Card(rank: .ace, suit: .diamond).suit.pipOutline, "♢")
		XCTAssertEqual(Deck.Card(rank: .ace, suit: .heart).suit.pipOutline, "♡")
	}

	func testDescriptions() throws {
		XCTAssertEqual(Deck.Card(rank: .ace, suit: .club).description, "ace of clubs")
		XCTAssertEqual(Deck.Card(rank: .two, suit: .diamond).description, "two of diamonds")
		XCTAssertEqual(Deck.Card(rank: .three, suit: .heart).description, "three of hearts")
		XCTAssertEqual(Deck.Card(rank: .four, suit: .spade).description, "four of spades")
		XCTAssertEqual(Deck.Card(rank: .five, suit: .club).description, "five of clubs")
		XCTAssertEqual(Deck.Card(rank: .six, suit: .diamond).description, "six of diamonds")
		XCTAssertEqual(Deck.Card(rank: .seven, suit: .heart).description, "seven of hearts")
		XCTAssertEqual(Deck.Card(rank: .eight, suit: .spade).description, "eight of spades")
		XCTAssertEqual(Deck.Card(rank: .nine, suit: .club).description, "nine of clubs")
		XCTAssertEqual(Deck.Card(rank: .ten, suit: .diamond).description, "ten of diamonds")
		XCTAssertEqual(Deck.Card(rank: .jack, suit: .heart).description, "jack of hearts")
		XCTAssertEqual(Deck.Card(rank: .queen, suit: .spade).description, "queen of spades")
		XCTAssertEqual(Deck.Card(rank: .king, suit: .club).description, "king of clubs")
	}
}

private extension PlayingCardsTests {
	func stringRepresentation(of deck: Deck) -> String {
		var copy = deck
		return copy.draw(count: .max).map {
			$0.suit.pipFill + "\($0.value)"
		}.joined()
	}
}
