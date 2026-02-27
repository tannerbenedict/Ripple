//
//  Game.swift
//  Ripple
//
//  Created on 2/26/26.
//

import Foundation

/// The current phase of the game.
enum GamePhase {
    case initialFlip   // Each player flips 3 cards
    case playing       // Draw/discard main gameplay
    case finished
}

/// Manages the state of a Ripple game.
class Game {

    /// The deck used for this game.
    let deck = Deck()

    /// The discard pile (top card is last element).
    private(set) var discardPile: [Card] = []

    /// All players in the game (index 0 is the human player).
    private(set) var players: [Player] = []

    /// Index of the player whose turn it is.
    private(set) var currentPlayerIndex: Int = 0

    /// Current game phase.
    private(set) var phase: GamePhase = .initialFlip

    /// Index of the player who goes first (for first-turn bonus draw).
    private(set) var firstPlayerIndex: Int = 0

    /// How many players have completed their initial 3-card flip.
    private(set) var initialFlipsCompleted: Int = 0

    /// Whether the current player has already drawn a card this turn.
    var hasDrawnCard: Bool = false

    /// The card the current player drew (nil if none drawn yet).
    var drawnCard: Card?

    /// Whether the first player has used their bonus re-draw after discarding.
    var firstPlayerUsedBonusDraw: Bool = false

    /// Index of the player who triggered the end of the most recent round.
    private(set) var roundTriggerIndex: Int = 0

    /// The current player.
    var currentPlayer: Player {
        return players[currentPlayerIndex]
    }

    /// The human player (always first in the array).
    var humanPlayer: Player {
        return players[0]
    }

    /// Number of cards dealt to each player.
    let cardsPerPlayer = 10

    /// The top card of the discard pile, if any.
    var topDiscard: Card? {
        return discardPile.last
    }

    /// Whether the current turn is the very first turn of the playing phase.
    var isFirstTurn: Bool {
        return currentPlayerIndex == firstPlayerIndex && !firstPlayerUsedBonusDraw
    }

    /// Initialize a game with the given number of AI opponents.
    init(opponentCount: Int) {
        let human = Player(name: "You", icon: "person.circle.fill", isAI: false)
        players.append(human)

        var usedNameIndices = Set<Int>()
        for _ in 1...opponentCount {
            var nameIndex: Int
            repeat {
                nameIndex = Int.random(in: 0..<Player.aiNames.count)
            } while usedNameIndices.contains(nameIndex)
            usedNameIndices.insert(nameIndex)

            let name = Player.aiNames[nameIndex]
            let icon = Player.aiIcons[nameIndex]
            let ai = Player(name: name, icon: icon, isAI: true)
            players.append(ai)
        }
    }

    /// Deal cards to all players from the deck and pick a random starting player.
    func dealCards() {
        deck.reset()
        discardPile = []

        for player in players {
            let hand = deck.draw(count: cardsPerPlayer)
            player.deal(cards: hand)
        }

        // Choose a random player to go first
        currentPlayerIndex = Int.random(in: 0..<players.count)
        firstPlayerIndex = currentPlayerIndex
        phase = .initialFlip
        initialFlipsCompleted = 0
        hasDrawnCard = false
        drawnCard = nil
        firstPlayerUsedBonusDraw = false
        totalScores = Array(repeating: 0, count: players.count)
    }

    /// Mark that the current player finished their initial flip.
    func completeInitialFlip() {
        initialFlipsCompleted += 1
        if initialFlipsCompleted >= players.count {
            phase = .playing
            // First player in play phase is the same starting player
            currentPlayerIndex = firstPlayerIndex
        } else {
            nextTurn()
        }
    }

    /// Draw a card from the draw pile for the current player.
    func drawFromDeck() -> Card? {
        guard let card = deck.draw() else { return nil }
        drawnCard = card
        hasDrawnCard = true
        return card
    }

    /// Draw the top card from the discard pile.
    func drawFromDiscard() -> Card? {
        guard let card = discardPile.popLast() else { return nil }
        drawnCard = card
        hasDrawnCard = true
        return card
    }

    /// Discard the drawn card onto the discard pile.
    func discardDrawnCard() {
        guard let card = drawnCard else { return }
        discardPile.append(card)
        drawnCard = nil
    }

    /// Discard a specific card onto the discard pile.
    func discard(_ card: Card) {
        discardPile.append(card)
    }

    /// End the current player's main-phase turn and advance.
    func endMainTurn() {
        hasDrawnCard = false
        drawnCard = nil
        if isFirstTurn {
            firstPlayerUsedBonusDraw = true
        }
        nextTurn()
    }

    /// Advance to the next player's turn.
    func nextTurn() {
        currentPlayerIndex = (currentPlayerIndex + 1) % players.count
    }

    // MARK: - Round End

    /// Check whether any player has all cards face-up; if so, end the round.
    /// Returns the index of the player who triggered the round end, or nil.
    @discardableResult
    func checkRoundEnd() -> Int? {
        for (index, player) in players.enumerated() {
            if player.allRevealed {
                phase = .finished
                roundTriggerIndex = index
                return index
            }
        }
        return nil
    }

    /// Cumulative scores across rounds (one entry per player).
    var totalScores: [Int] = []

    /// Reveal all remaining face-down cards for every player (called at round end).
    func revealAllCards() {
        for player in players {
            for i in 0..<player.faceUp.count where !player.faceUp[i] {
                player.revealCard(at: i)
            }
        }
    }

    // MARK: - Scoring

    /// The point value of a single card.
    /// 7, 11, and Ripple cards are worth 0; all others are face value.
    static func cardPointValue(_ card: Card) -> Int {
        switch card {
        case .number(7), .number(11):
            return 0
        case .number(let value):
            return value
        case .ripple:
            return 0
        }
    }

    /// Calculate the round score for a player using column-based scoring.
    /// - Matching pair (top == bottom): 0 points for that column.
    /// - N adjacent columns (N ≥ 2) all sharing the same card: -(N × 20) points.
    /// - Non-matching column: sum of each card's point value.
    func score(for player: Player) -> Int {
        // Build columns: index 0-4 = top row, 5-9 = bottom row
        struct Column {
            let top: Card
            let bottom: Card
            var isPair: Bool { top == bottom }
        }
        var columns: [Column] = []
        for col in 0..<5 {
            columns.append(Column(top: player.cards[col], bottom: player.cards[col + 5]))
        }

        var score = 0
        var processed = Array(repeating: false, count: 5)

        // Find runs of adjacent matching-pair columns with the same card
        var i = 0
        while i < 5 {
            if columns[i].isPair {
                let pairCard = columns[i].top
                var runLength = 1
                while i + runLength < 5,
                      columns[i + runLength].isPair,
                      columns[i + runLength].top == pairCard {
                    runLength += 1
                }

                if runLength >= 2 {
                    // Multi-column bonus: -(N × 20)
                    score += -(runLength * 20)
                    for j in i..<(i + runLength) {
                        processed[j] = true
                    }
                } else {
                    // Single matching pair = 0 points
                    processed[i] = true
                }
                i += runLength
            } else {
                i += 1
            }
        }

        // Add remaining unprocessed (non-matching) columns
        for col in 0..<5 where !processed[col] {
            score += Game.cardPointValue(columns[col].top) + Game.cardPointValue(columns[col].bottom)
        }

        return score
    }

    // MARK: - Multi-Round

    /// Apply round scores to cumulative totals.
    func applyRoundScores() {
        if totalScores.isEmpty {
            totalScores = Array(repeating: 0, count: players.count)
        }
        for (i, player) in players.enumerated() {
            totalScores[i] += score(for: player)
        }
    }

    /// Check whether the game is over (any player's total ≤ -100 or ≥ 100).
    func isGameOver() -> Bool {
        return totalScores.contains { $0 <= -100 || $0 >= 100 }
    }

    /// Return the index of the player with the lowest round score (first player next round).
    /// On a tie, the player who triggered the round end (flipped all cards first) wins the tiebreaker.
    func lowestRoundScorePlayerIndex() -> Int {
        var bestIndex = 0
        var bestScore = score(for: players[0])
        for i in 1..<players.count {
            let s = score(for: players[i])
            if s < bestScore {
                bestScore = s
                bestIndex = i
            } else if s == bestScore && i == roundTriggerIndex {
                bestIndex = i
            }
        }
        return bestIndex
    }

    /// Start a new round: re-shuffle the deck, re-deal cards. Lowest scorer goes first.
    func startNewRound() {
        let starter = lowestRoundScorePlayerIndex()

        deck.reset()
        discardPile = []

        for player in players {
            let hand = deck.draw(count: cardsPerPlayer)
            player.deal(cards: hand)
        }

        currentPlayerIndex = starter
        firstPlayerIndex = starter
        phase = .initialFlip
        initialFlipsCompleted = 0
        hasDrawnCard = false
        drawnCard = nil
        firstPlayerUsedBonusDraw = false
    }
}
