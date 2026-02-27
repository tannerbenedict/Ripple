//
//  Player.swift
//  Ripple
//
//  Created on 2/26/26.
//

import Foundation

/// Represents a player in the Ripple game.
class Player {

    /// The player's display name.
    let name: String

    /// SF Symbol name used as the player's icon.
    let icon: String

    /// Whether this player is controlled by AI.
    let isAI: Bool

    /// The player's 10 cards laid out in a 2×5 grid.
    /// Index 0–4 = top row, 5–9 = bottom row.
    var cards: [Card] = []

    /// Tracks which cards are face-up (revealed).
    /// Matches indices of `cards`.
    var faceUp: [Bool] = Array(repeating: false, count: 10)

    /// Random AI display names.
    static let aiNames = [
        "Ace", "Blaze", "Coral", "Dash", "Echo",
        "Finn", "Glow", "Haze", "Ivy", "Jazz",
        "Kai", "Luna", "Mist", "Nova", "Onyx",
        "Pixel", "Quinn", "Reef", "Sky", "Tidal"
    ]

    /// SF Symbols used as AI player icons.
    static let aiIcons = [
        "hare.fill", "tortoise.fill", "bird.fill", "ant.fill", "fish.fill",
        "bolt.fill", "flame.fill", "leaf.fill", "star.fill", "moon.fill",
        "sun.max.fill", "cloud.fill", "snowflake", "drop.fill", "wind",
        "pawprint.fill", "ladybug.fill", "cat.fill", "dog.fill", "lizard.fill"
    ]

    init(name: String, icon: String = "person.circle.fill", isAI: Bool = false) {
        self.name = name
        self.icon = icon
        self.isAI = isAI
    }

    /// Deal 10 cards to this player, all face-down.
    func deal(cards: [Card]) {
        self.cards = cards
        self.faceUp = Array(repeating: false, count: cards.count)
    }

    /// Flip a card face-up at the given index.
    func revealCard(at index: Int) {
        guard index >= 0 && index < faceUp.count else { return }
        faceUp[index] = true
    }

    /// Replace the card at the given index with a new card (face-up).
    /// Returns the old card that was there.
    @discardableResult
    func replaceCard(at index: Int, with newCard: Card) -> Card {
        let old = cards[index]
        cards[index] = newCard
        faceUp[index] = true
        return old
    }

    /// Return the index of the other card in the same column.
    /// Column is index % 5; rows are 0-4 (top) and 5-9 (bottom).
    func partnerIndex(of index: Int) -> Int {
        return index < 5 ? index + 5 : index - 5
    }

    /// Whether all cards have been revealed.
    var allRevealed: Bool {
        return faceUp.allSatisfy { $0 }
    }
}
