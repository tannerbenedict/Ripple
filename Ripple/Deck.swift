//
//  Deck.swift
//  Ripple
//
//  Created on 2/26/26.
//

import Foundation

/// Manages a full deck of Ripple cards.
class Deck {

    /// The cards remaining in the deck.
    private(set) var cards: [Card] = []

    init() {
        reset()
    }

    /// Build and shuffle a fresh deck.
    /// - 12 copies of each number 1–12 (144 cards)
    /// - 18 Ripple cards
    /// - Total: 162 cards
    func reset() {
        cards = []

        for number in 1...12 {
            for _ in 1...12 {
                cards.append(.number(number))
            }
        }

        for _ in 1...18 {
            cards.append(.ripple)
        }

        shuffle()
    }

    /// Shuffle the remaining cards in the deck.
    func shuffle() {
        cards.shuffle()
    }

    /// Draw a single card from the top of the deck.
    /// Returns nil if the deck is empty.
    func draw() -> Card? {
        guard !cards.isEmpty else { return nil }
        return cards.removeFirst()
    }

    /// Draw multiple cards from the top of the deck.
    func draw(count: Int) -> [Card] {
        var drawn: [Card] = []
        for _ in 0..<count {
            guard let card = draw() else { break }
            drawn.append(card)
        }
        return drawn
    }

    /// The number of cards remaining in the deck.
    var remaining: Int {
        return cards.count
    }

    /// Whether the deck is empty.
    var isEmpty: Bool {
        return cards.isEmpty
    }
}
