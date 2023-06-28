# PlayingCards
Swift package that models a deck of playing cards

## Installation

### Swift Package Manager
```swift
dependencies: [
    .package(url: "https://github.com/nchiu/PlayingCards", from: "1.0.0")
]
```

## Model

## View

## Example

```swift
import SwiftUI
import PlayingCards

struct ContentView: View {
	// MARK: Properties
	@State private var deck = Deck()
	@State private var currentCard: Deck.Card?

	// MARK: View
	var body: some View {
		ScrollView {
			VStack {
				controls
				Color.gray
					.frame(height: 1)
				remainingCards
			}
		}
	}
}

// MARK: - Private
private extension ContentView {
	@ViewBuilder
	var controls: some View {
		HStack {
			Button {
				deck = .init()
				currentCard = nil
			} label: {
				VStack {
					Image(systemName: "arrow.counterclockwise")
					Text("Reset")
				}
			}

			Button {
				deck.shuffle()
			} label: {
				VStack {
					Image(systemName: "shuffle")
					Text("Shuffle")
				}
			}
			.disabled(deck.isEmpty)

			Spacer()

			Button {
				currentCard = deck.draw()
			} label: {
				VStack {
					Image(systemName: "arrowtriangle.forward")
					Text("Draw")
				}
			}
			.disabled(deck.isEmpty)

			ZStack {
				Color.gray
					.opacity(0.5)
				if let currentCard {
					PlayingCardView(card: currentCard)
						.padding(3)
				}
			}
			.frame(width: 110, height: 150)
		}
		.padding()
	}

	@ViewBuilder
	var remainingCards: some View {
		VStack(alignment: .leading) {
			Text("Remaining cards in deck")
			LazyVGrid(columns: [.init(.adaptive(minimum: 50))]) {
				ForEach(deck.peak().reversed()) {
					PlayingCardView(card: $0)
				}
			}
		}
		.padding()
	}
}
```

![Example code running](/Images/example.gif)
