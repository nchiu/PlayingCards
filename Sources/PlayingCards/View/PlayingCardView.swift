//
//  PlayingCardView.swift
//  
//
//  Created by Nathan Chiu on 6/19/23.
//

import SwiftUI

/// A view to display a specified playing card.
public struct PlayingCardView: View {

	// MARK: Properties

	/// The card to display
	let card: Deck.Card

	/// The name of the font used in the text elements of the playing card
	let fontName: String

	// MARK: Initializers

	/// Creates a new `PlayingCardView`
	/// - Parameters:
	///   - card: The card to display
	///   - fontName: The name of the font used in the text elements of the playing card. Optional, defaults to `"Futura"`
	init(card: Deck.Card, fontName: String = "Futura") {
		self.card = card
		self.fontName = fontName
	}

	// MARK: Environment
	@Environment(\.colorScheme) var colorScheme

	// MARK: View
	public var body: some View {
		GeometryReader { geometry in
			ZStack {
				RoundedRectangle(cornerRadius: geometry.size.height / 15, style: .continuous)
					.strokeBorder(outlineColor)

				if geometry.size.isCompact {
					rankCornerText(forSize: geometry.size)
				} else {
					HStack(spacing: 0) {
						VStack(spacing: 0) {
							rankCornerText(forSize: geometry.size)
							Spacer.zero
						}
						Spacer(minLength: geometry.size.width * 0.025)
						pipContent(forSize: geometry.size)
							.padding(.vertical)
						Spacer(minLength: geometry.size.width * 0.025)
						VStack(spacing: 0) {
							Spacer.zero
							rankCornerText(forSize: geometry.size)
								.upsideDown
						}
					}
					.padding(geometry.size.height / 25)
				}
			}
		}
		.aspectRatio(aspectRatio, contentMode: .fit)
		.background { Color.clear }
		.accessibilityLabel(.init(card.description))
	}
}

// MARK: Public
public extension PlayingCardView {

}

// MARK: - Private
private extension PlayingCardView {
	var aspectRatio: CGFloat { 63 / 88 }

	var backgroundColor: Color {
		switch colorScheme {
		case .light: return .white
		case .dark: return .black
		@unknown default: return .white
		}
	}

	var outlineColor: Color {
		switch colorScheme {
		case .light: return .black
		case .dark: return .white
		@unknown default: return .black
		}
	}

	var suitColor: Color {
		switch card.suit.color {
		case .black:
			switch colorScheme {
			case .light: return .black
			case .dark: return .white
			@unknown default: return .black
			}
		case .red:
			return.red
		}
	}

	func rankCornerText(forSize size: CGSize) -> some View {
		VStack(spacing: .zero) {
			Text(card.rank.symbol)
				.fontWidth(.compressed)
				.font(
					.custom(
						fontName,
						size: size.height / (size.isCompact ? 3 : 12),
						relativeTo: .body
					)
				)
			switch card.rank {
			case .ace, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .jack, .queen, .king:
				Text(card.suit.pipFill)
					.font(
						.custom(
							fontName,
							size: size.height / (size.isCompact ? 3 : 17),
							relativeTo: .body
						)
					)
			case .joker: EmptyView()
			}
		}
		.foregroundColor(suitColor)
	}

	func pipContent(forSize size: CGSize) -> some View {
		var pip: some View {
			var heightPercentage: CGFloat {
				switch card.rank {
				case .ace: return 1 / 3
				case .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .jack, .queen, .king, .joker: return 1 / 6
				}
			}

			return Text(card.suit.pipFill)
				.font(
					.custom(
						fontName,
						size: size.height * heightPercentage,
						relativeTo: .body
					)
				)
				.minimumScaleFactor(0.5)
		}

		return Group {
			if card.rank.isFaceCard {
				switch card.rank {
				case .ace, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten:
					// Not face cards, this case should never be reached
					Image(sfSymbol: .questionMarkSquareDashed)
				case .jack:
					Image(sfSymbol: .partyPopper) // TODO: get face card images
						.resizable()
						.scaledToFit()
						.padding()
				case .queen:
					Image(sfSymbol: .crown) // TODO: get face card images
						.resizable()
						.scaledToFit()
						.padding()
				case .king:
					Image(sfSymbol: .crownFill) // TODO: get face card images
						.resizable()
						.scaledToFit()
						.padding()
				case .joker:
					Image(sfSymbol: .theaterMasks) // TODO: get face card images
						.resizable()
						.scaledToFit()
						.padding()
				}
			} else {
				// Not a face card, layout pips
				// Leading column
				VStack(spacing: 0) {
					pip
					if card.rank.pips > 1 {
						if card.rank.pips == 3 || card.rank.pips > 5 {
							Spacer.zero
							pip
						}
						Spacer.zero
						pip.upsideDown
						if card.rank.pips > 7 {
							Spacer.zero
							pip.upsideDown
						}
					}
				}

				// Center column
				if card.rank.pips > 3 {
					if card.rank.pips.isOdd || card.rank.pips > 9 {
						VStack(spacing: 0) {
							Spacer.zero
							pip
							Spacer.zero
							if card.rank.pips > 6 {
								pip.upsideDown
									.opacity(card.rank.pips == 10 ? 1 : 0)
								Spacer.zero
							}
						}
					} else {
						Spacer.zero
					}
				}

				// Trailing column
				if card.rank.pips > 3 {
					VStack(spacing: 0) {
						pip
						if card.rank.pips > 5 {
							Spacer.zero
							pip
						}
						Spacer.zero
						pip.upsideDown
						if card.rank.pips > 7 {
							Spacer.zero
							pip.upsideDown
						}
					}
				}
			}
		}
		.foregroundColor(suitColor)
	}
}

private extension CGSize {
	var isCompact: Bool { width <= 100 }
}

private extension Spacer {
	static var zero: Self { .init(minLength: .zero) }
}

private extension View {
	var upsideDown: some View {
		self.rotationEffect(.degrees(180))
	}
}

// MARK: Preview Provider
struct SwiftUIView_Previews: PreviewProvider {
	static var previews: some View {
		ScrollView {
			VStack {
				ForEach(Deck.Card.Suit.allCases, id: \.self) { suit in
					ForEach(Deck.Card.Rank.allCases, id: \.self) { rank in
						VStack {
							PlayingCardView(card: .init(rank: rank, suit: suit))
							HStack {
								PlayingCardView(card: .init(rank: rank, suit: suit))
								PlayingCardView(card: .init(rank: rank, suit: suit))
							}
							HStack {
								PlayingCardView(card: .init(rank: rank, suit: suit))
								PlayingCardView(card: .init(rank: rank, suit: suit))
								PlayingCardView(card: .init(rank: rank, suit: suit))
								PlayingCardView(card: .init(rank: rank, suit: suit))
							}
						}
					}
				}
			}
			.padding()
			.frame(maxWidth: 350)
		}
	}
}
