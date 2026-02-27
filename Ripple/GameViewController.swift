//
//  GameViewController.swift
//  Ripple
//
//  Created on 2/26/26.
//

import UIKit

class GameViewController: UIViewController {

    // MARK: - Properties

    private var game: Game
    private var playerCardViews: [[CardView]] = []   // one array of 10 CardViews per player
    private var playerIconViews: [UIImageView] = []  // icon view per player for highlighting
    private var playerScoreLabels: [UILabel] = []    // cumulative score label per player
    private let topContainer = UIView()      // opponent boards
    private let bottomContainer = UIView()   // human player board

    // Draw / discard pile views
    private let drawPileView = CardView()
    private let discardPileView = CardView()
    private let drawPileLabel = UILabel()
    private let discardPileLabel = UILabel()
    private let pileContainer = UIView()

    // Drawn card preview (shown when the player draws)
    private let drawnCardView = CardView()
    private let drawnCardLabel = UILabel()
    private let keepButton = UIButton(type: .system)
    private let discardButton = UIButton(type: .system)

    // MARK: - Init

    private let opponentCount: Int

    init(opponentCount: Int) {
        self.opponentCount = opponentCount
        self.game = Game(opponentCount: opponentCount)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startGame()
    }

    // MARK: - Setup

    private let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()

    private func setupUI() {
        view.backgroundColor = .black
        title = "Ripple"

        // Background image
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        updateBackgroundImage()

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Quit",
            style: .plain,
            target: self,
            action: #selector(quitTapped)
        )

        // Three-zone layout: opponents (top) | piles (middle) | human (bottom)
        topContainer.translatesAutoresizingMaskIntoConstraints = false
        topContainer.backgroundColor = .clear
        view.addSubview(topContainer)

        pileContainer.translatesAutoresizingMaskIntoConstraints = false
        pileContainer.backgroundColor = UIColor.secondarySystemBackground.withAlphaComponent(0.85)
        pileContainer.layer.cornerRadius = 10
        view.addSubview(pileContainer)

        bottomContainer.translatesAutoresizingMaskIntoConstraints = false
        bottomContainer.backgroundColor = .clear
        view.addSubview(bottomContainer)

        NSLayoutConstraint.activate([
            topContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            topContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            pileContainer.topAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: 4),
            pileContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pileContainer.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.6),
            pileContainer.heightAnchor.constraint(equalToConstant: 60),

            bottomContainer.topAnchor.constraint(equalTo: pileContainer.bottomAnchor, constant: 4),
            bottomContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])

        // Split remaining vertical space: opponents get opponentCount shares, human gets 1 share
        if opponentCount > 0 {
            topContainer.heightAnchor.constraint(
                equalTo: bottomContainer.heightAnchor,
                multiplier: CGFloat(opponentCount)
            ).isActive = true
        } else {
            topContainer.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }

        setupPileUI()
    }

    private func setupPileUI() {
        // Compact horizontal layout: [Draw] [Discard] [DrawnCard] [Discard Button]
        drawPileView.translatesAutoresizingMaskIntoConstraints = false
        drawPileView.configure(with: .number(0), faceUp: false)
        drawPileView.onTap = { [weak self] in self?.drawPileTapped() }
        pileContainer.addSubview(drawPileView)

        drawPileLabel.text = "Draw"
        drawPileLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        drawPileLabel.textColor = .secondaryLabel
        drawPileLabel.textAlignment = .center
        drawPileLabel.translatesAutoresizingMaskIntoConstraints = false
        pileContainer.addSubview(drawPileLabel)

        discardPileView.translatesAutoresizingMaskIntoConstraints = false
        discardPileView.onTap = { [weak self] in self?.discardPileTapped() }
        updateDiscardPileView()
        pileContainer.addSubview(discardPileView)

        discardPileLabel.text = "Discard"
        discardPileLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        discardPileLabel.textColor = .secondaryLabel
        discardPileLabel.textAlignment = .center
        discardPileLabel.translatesAutoresizingMaskIntoConstraints = false
        pileContainer.addSubview(discardPileLabel)

        drawnCardView.translatesAutoresizingMaskIntoConstraints = false
        drawnCardView.isHidden = true
        pileContainer.addSubview(drawnCardView)

        drawnCardLabel.text = "Your draw"
        drawnCardLabel.font = UIFont.systemFont(ofSize: 10, weight: .medium)
        drawnCardLabel.textColor = .secondaryLabel
        drawnCardLabel.textAlignment = .center
        drawnCardLabel.translatesAutoresizingMaskIntoConstraints = false
        drawnCardLabel.isHidden = true
        pileContainer.addSubview(drawnCardLabel)

        keepButton.setTitle("Keep", for: .normal)
        keepButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        keepButton.backgroundColor = .systemGreen
        keepButton.setTitleColor(.white, for: .normal)
        keepButton.layer.cornerRadius = 6
        keepButton.translatesAutoresizingMaskIntoConstraints = false
        keepButton.isHidden = true
        keepButton.addTarget(self, action: #selector(keepDrawnCard), for: .touchUpInside)
        pileContainer.addSubview(keepButton)

        discardButton.setTitle("Discard", for: .normal)
        discardButton.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        discardButton.backgroundColor = .systemRed
        discardButton.setTitleColor(.white, for: .normal)
        discardButton.layer.cornerRadius = 6
        discardButton.translatesAutoresizingMaskIntoConstraints = false
        discardButton.isHidden = true
        discardButton.addTarget(self, action: #selector(discardDrawnCard), for: .touchUpInside)
        pileContainer.addSubview(discardButton)

        let pileCardH: CGFloat = 40
        let pileCardW: CGFloat = 28

        NSLayoutConstraint.activate([
            drawPileView.leadingAnchor.constraint(equalTo: pileContainer.leadingAnchor, constant: 12),
            drawPileView.centerYAnchor.constraint(equalTo: pileContainer.centerYAnchor, constant: -6),
            drawPileView.widthAnchor.constraint(equalToConstant: pileCardW),
            drawPileView.heightAnchor.constraint(equalToConstant: pileCardH),

            drawPileLabel.topAnchor.constraint(equalTo: drawPileView.bottomAnchor, constant: 1),
            drawPileLabel.centerXAnchor.constraint(equalTo: drawPileView.centerXAnchor),

            discardPileView.leadingAnchor.constraint(equalTo: drawPileView.trailingAnchor, constant: 10),
            discardPileView.centerYAnchor.constraint(equalTo: drawPileView.centerYAnchor),
            discardPileView.widthAnchor.constraint(equalToConstant: pileCardW),
            discardPileView.heightAnchor.constraint(equalToConstant: pileCardH),

            discardPileLabel.topAnchor.constraint(equalTo: discardPileView.bottomAnchor, constant: 1),
            discardPileLabel.centerXAnchor.constraint(equalTo: discardPileView.centerXAnchor),

            drawnCardView.leadingAnchor.constraint(equalTo: discardPileView.trailingAnchor, constant: 16),
            drawnCardView.centerYAnchor.constraint(equalTo: drawPileView.centerYAnchor),
            drawnCardView.widthAnchor.constraint(equalToConstant: pileCardW),
            drawnCardView.heightAnchor.constraint(equalToConstant: pileCardH),

            drawnCardLabel.topAnchor.constraint(equalTo: drawnCardView.bottomAnchor, constant: 1),
            drawnCardLabel.centerXAnchor.constraint(equalTo: drawnCardView.centerXAnchor),

            discardButton.leadingAnchor.constraint(equalTo: drawnCardView.trailingAnchor, constant: 12),
            discardButton.centerYAnchor.constraint(equalTo: pileContainer.centerYAnchor),
            discardButton.widthAnchor.constraint(equalToConstant: 70),
            discardButton.heightAnchor.constraint(equalToConstant: 30),
            discardButton.trailingAnchor.constraint(lessThanOrEqualTo: pileContainer.trailingAnchor, constant: -12),

            keepButton.leadingAnchor.constraint(equalTo: discardButton.leadingAnchor),
            keepButton.centerYAnchor.constraint(equalTo: pileContainer.centerYAnchor),
            keepButton.widthAnchor.constraint(equalTo: discardButton.widthAnchor),
            keepButton.heightAnchor.constraint(equalTo: discardButton.heightAnchor),
        ])

        pileContainer.isHidden = true  // Hidden during initial flip phase
    }

    private func updateDiscardPileView() {
        if let topCard = game.topDiscard {
            discardPileView.configure(with: topCard, faceUp: true)
        } else {
            // Empty discard pile
            discardPileView.configure(with: .number(0), faceUp: false)
            discardPileView.alpha = 0.3
        }
    }

    private func showDrawnCard(_ card: Card) {
        drawnCardView.configure(with: card, faceUp: true)
        drawnCardView.isHidden = false
        drawnCardLabel.isHidden = false
        drawnCardLabel.text = "Tap a card to replace"
        keepButton.isHidden = true  // replaced by tapping a card
        discardButton.isHidden = false
    }

    private func hideDrawnCard() {
        drawnCardView.isHidden = true
        drawnCardLabel.isHidden = true
        keepButton.isHidden = true
        discardButton.isHidden = true
    }

    /// Columns already used by the current player this turn (0-4).
    private var columnsUsedThisTurn: Set<Int> = []

    /// Number of cards flipped by the current player this turn.
    private var cardsFlippedThisTurn: Int = 0

    /// Max cards a player can flip per turn.
    private let maxFlipsPerTurn = 3

    /// Whether input is blocked (e.g. during AI animation).
    private var inputLocked: Bool = false

    // MARK: - Game

    private func startGame() {
        game.dealCards()
        buildPlayerBoards()
        highlightCurrentPlayer()
        beginTurn()
    }

    /// Highlight the icon of the player whose turn it is.
    private func highlightCurrentPlayer() {
        for (index, iconView) in playerIconViews.enumerated() {
            if index == game.currentPlayerIndex {
                iconView.tintColor = .systemGreen
                iconView.layer.shadowColor = UIColor.systemGreen.cgColor
                iconView.layer.shadowRadius = 6
                iconView.layer.shadowOpacity = 0.8
                iconView.layer.shadowOffset = .zero
            } else {
                iconView.tintColor = .systemBlue
                iconView.layer.shadowOpacity = 0
            }
        }
    }

    // MARK: - Turn Flow

    /// Start the current player's turn.
    private func beginTurn() {
        columnsUsedThisTurn = []
        cardsFlippedThisTurn = 0

        let player = game.currentPlayer

        if game.phase == .initialFlip {
            if player.isAI {
                inputLocked = true
                performAIFlipTurn()
            } else {
                inputLocked = false
                highlightEligibleCards()
            }
        } else {
            // Main playing phase
            pileContainer.isHidden = false
            hideDrawnCard()
            if player.isAI {
                inputLocked = true
                performAIMainTurn()
            } else {
                inputLocked = false
                // Human taps the draw pile to begin
            }
        }
    }

    /// Advance to the next player and begin their turn.
    private func advanceTurn() {
        clearHighlights()
        if game.phase == .initialFlip {
            game.completeInitialFlip()
        } else {
            game.endMainTurn()
        }

        // Check if any player has all cards face-up → round over
        if let triggerIndex = game.checkRoundEnd() {
            endRound(triggeredBy: triggerIndex)
            return
        }

        highlightCurrentPlayer()
        beginTurn()
    }

    // MARK: - Round End

    /// Called when a player has all cards face-up. Reveals everyone's cards and shows results.
    private func endRound(triggeredBy triggerIndex: Int) {
        inputLocked = true

        // Reveal all remaining face-down cards
        game.revealAllCards()

        // Update every card view to face-up
        for (playerIdx, player) in game.players.enumerated() {
            for (cardIdx, card) in player.cards.enumerated() {
                let cardView = playerCardViews[playerIdx][cardIdx]
                if !cardView.isFaceUp {
                    cardView.configure(with: card, faceUp: true)
                }
            }
        }

        // Apply round scores to cumulative totals
        game.applyRoundScores()

        // Update on-screen score labels
        updateScoreLabels()

        // Build the results message
        let triggerPlayer = game.players[triggerIndex]
        var message = "\(triggerPlayer.name) revealed all their cards!\n\n"
        message += "Round Scores:\n"
        for (i, player) in game.players.enumerated() {
            let roundScore = game.score(for: player)
            message += "\(player.name): \(roundScore)\n"
        }
        message += "\nTotal Scores:\n"
        var totals: [(name: String, total: Int)] = []
        for (i, player) in game.players.enumerated() {
            totals.append((name: player.name, total: game.totalScores[i]))
            message += "\(player.name): \(game.totalScores[i])\n"
        }

        let gameOver = game.isGameOver()
        if gameOver {
            totals.sort { $0.total < $1.total }
            let winner = totals.first!
            message += "\n🏆 \(winner.name) wins the game!"
        }

        // Show results alert after a brief delay so the reveal is visible
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [weak self] in
            guard let self = self else { return }
            let title = gameOver ? "Game Over" : "Round Over"
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

            if gameOver {
                alert.addAction(UIAlertAction(title: "Play Again", style: .default) { _ in
                    self.restartGame()
                })
                alert.addAction(UIAlertAction(title: "Back to Menu", style: .cancel) { _ in
                    self.dismiss(animated: true)
                })
            } else {
                alert.addAction(UIAlertAction(title: "Next Round", style: .default) { _ in
                    self.beginNewRound()
                })
            }

            self.present(alert, animated: true)
        }
    }

    /// Start a new round with fresh cards.
    private func beginNewRound() {
        game.startNewRound()
        buildPlayerBoards()
        updateScoreLabels()
        updateDiscardPileView()
        hideDrawnCard()
        pileContainer.isHidden = false
        awaitingCardPlacement = false
        inputLocked = false
        highlightCurrentPlayer()
        beginTurn()
    }

    /// Start an entirely new game with fresh players and scores.
    private func restartGame() {
        game = Game(opponentCount: opponentCount)
        game.dealCards()
        buildPlayerBoards()
        updateScoreLabels()
        updateDiscardPileView()
        hideDrawnCard()
        pileContainer.isHidden = false
        awaitingCardPlacement = false
        inputLocked = false
        highlightCurrentPlayer()
        beginTurn()
    }

    /// Refresh the score labels shown next to each player name.
    private func updateScoreLabels() {
        for (i, label) in playerScoreLabels.enumerated() {
            label.text = "Score: \(game.totalScores[i])"
        }
    }

    /// Whether we are waiting for the human to pick a card to replace.
    private var awaitingCardPlacement: Bool = false

    // MARK: - Draw Pile Interaction

    private func drawPileTapped() {
        guard !inputLocked else { return }
        guard game.phase == .playing else { return }
        guard !game.currentPlayer.isAI else { return }
        guard !game.hasDrawnCard else { return }

        guard let card = game.drawFromDeck() else { return }
        showDrawnCard(card)
        awaitingCardPlacement = true
        highlightPlaceableCards()
    }

    private func discardPileTapped() {
        guard !inputLocked else { return }
        guard game.phase == .playing else { return }
        guard !game.currentPlayer.isAI else { return }
        guard !game.hasDrawnCard else { return }
        guard game.topDiscard != nil else { return }

        guard let card = game.drawFromDiscard() else { return }
        showDrawnCard(card)
        updateDiscardPileView()
        awaitingCardPlacement = true
        highlightPlaceableCards()
    }

    /// Highlight all of the current player's cards as placeable targets.
    private func highlightPlaceableCards() {
        let playerIndex = game.currentPlayerIndex
        let views = playerCardViews[playerIndex]
        for cardView in views {
            cardView.setHighlighted(true)
        }
    }

    @objc private func keepDrawnCard() {
        // "Keep" is no longer used — player must tap a card to replace.
        // Hidden for safety.
    }

    @objc private func discardDrawnCard() {
        awaitingCardPlacement = false
        clearHighlights()
        game.discardDrawnCard()
        updateDiscardPileView()
        discardPileView.alpha = 1.0
        hideDrawnCard()

        // First player gets a bonus re-draw
        if game.isFirstTurn {
            game.firstPlayerUsedBonusDraw = true
            game.hasDrawnCard = false
        } else {
            advanceTurn()
        }
    }

    // MARK: - Card Replacement (Ripple logic)

    /// Human tapped a card in their grid while holding a drawn card.
    private func handleCardPlacement(at index: Int) {
        let playerIndex = game.currentPlayerIndex
        let player = game.players[playerIndex]
        guard let drawnCard = game.drawnCard else { return }

        clearHighlights()
        awaitingCardPlacement = false

        let wasFaceUp = player.faceUp[index]
        let oldCard = player.replaceCard(at: index, with: drawnCard)
        game.drawnCard = nil
        game.hasDrawnCard = false

        // Update the card view
        playerCardViews[playerIndex][index].configure(with: drawnCard, faceUp: true)
        hideDrawnCard()

        if wasFaceUp {
            // Option 1: replaced a face-up card — discard old card, turn ends
            game.discard(oldCard)
            updateDiscardPileView()
            discardPileView.alpha = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
                self?.advanceTurn()
            }
        } else {
            // Option 2: replaced a face-down card — check for ripple chain
            performRippleChain(playerIndex: playerIndex, revealedCard: oldCard, fromIndex: index)
        }
    }

    /// Check if the revealed card matches any face-up card whose column partner
    /// is face-down. If so, replace that partner and continue the chain.
    private func performRippleChain(playerIndex: Int, revealedCard: Card, fromIndex: Int) {
        let player = game.players[playerIndex]

        // Find a face-up card that matches revealedCard where the column partner is face-down
        var matchIndex: Int? = nil
        for i in 0..<player.cards.count {
            guard i != fromIndex else { continue }
            guard player.faceUp[i] else { continue }
            guard player.cards[i] == revealedCard else { continue }

            let partner = player.partnerIndex(of: i)
            if !player.faceUp[partner] {
                matchIndex = partner
                break
            }
        }

        if let target = matchIndex {
            // Ripple! Replace the face-down partner with the revealed card
            let nextOldCard = player.replaceCard(at: target, with: revealedCard)
            playerCardViews[playerIndex][target].configure(with: revealedCard, faceUp: true)

            // Animate with a short delay, then continue the chain
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.performRippleChain(playerIndex: playerIndex, revealedCard: nextOldCard, fromIndex: target)
            }
        } else {
            // No more ripple — discard the last revealed card and end turn
            game.discard(revealedCard)
            updateDiscardPileView()
            discardPileView.alpha = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
                self?.advanceTurn()
            }
        }
    }

    // MARK: - AI Main Turn

    private func performAIMainTurn() {
        let playerIndex = game.currentPlayerIndex
        let player = game.players[playerIndex]

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [weak self] in
            guard let self = self else { return }

            // AI draws from the deck
            guard let card = self.game.drawFromDeck() else { return }
            self.game.drawnCard = nil
            self.game.hasDrawnCard = false

            // Simple AI: try to replace a face-down card
            let faceDownIndices = (0..<player.cards.count).filter { !player.faceUp[$0] }

            if let targetIdx = faceDownIndices.randomElement() {
                let oldCard = player.replaceCard(at: targetIdx, with: card)
                self.playerCardViews[playerIndex][targetIdx].configure(with: card, faceUp: true)

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.aiPerformRippleChain(playerIndex: playerIndex, revealedCard: oldCard, fromIndex: targetIdx)
                }
            } else {
                // All face-up: just discard
                self.game.discard(card)
                self.updateDiscardPileView()
                self.discardPileView.alpha = 1.0

                if self.game.isFirstTurn {
                    self.game.firstPlayerUsedBonusDraw = true
                    self.aiBonusDraw(playerIndex: playerIndex)
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.advanceTurn()
                    }
                }
            }
        }
    }

    /// AI ripple chain — same logic as human but auto-animated.
    private func aiPerformRippleChain(playerIndex: Int, revealedCard: Card, fromIndex: Int) {
        let player = game.players[playerIndex]

        var matchIndex: Int? = nil
        for i in 0..<player.cards.count {
            guard i != fromIndex else { continue }
            guard player.faceUp[i] else { continue }
            guard player.cards[i] == revealedCard else { continue }

            let partner = player.partnerIndex(of: i)
            if !player.faceUp[partner] {
                matchIndex = partner
                break
            }
        }

        if let target = matchIndex {
            let nextOldCard = player.replaceCard(at: target, with: revealedCard)
            playerCardViews[playerIndex][target].configure(with: revealedCard, faceUp: true)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                self?.aiPerformRippleChain(playerIndex: playerIndex, revealedCard: nextOldCard, fromIndex: target)
            }
        } else {
            game.discard(revealedCard)
            updateDiscardPileView()
            discardPileView.alpha = 1.0

            if game.isFirstTurn {
                game.firstPlayerUsedBonusDraw = true
                aiBonusDraw(playerIndex: playerIndex)
            } else {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                    self?.advanceTurn()
                }
            }
        }
    }

    /// AI first-player bonus draw.
    private func aiBonusDraw(playerIndex: Int) {
        let player = game.players[playerIndex]
        game.hasDrawnCard = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            guard let card = self.game.drawFromDeck() else {
                self.advanceTurn()
                return
            }
            self.game.drawnCard = nil
            self.game.hasDrawnCard = false

            let faceDownIndices = (0..<player.cards.count).filter { !player.faceUp[$0] }
            if let targetIdx = faceDownIndices.randomElement() {
                let oldCard = player.replaceCard(at: targetIdx, with: card)
                self.playerCardViews[playerIndex][targetIdx].configure(with: card, faceUp: true)

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.aiPerformRippleChain(playerIndex: playerIndex, revealedCard: oldCard, fromIndex: targetIdx)
                }
            } else {
                self.game.discard(card)
                self.updateDiscardPileView()
                self.discardPileView.alpha = 1.0
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.advanceTurn()
                }
            }
        }
    }

    // MARK: - Column Helpers

    /// Return the column (0-4) for a card index in the 2×5 grid.
    private func column(for cardIndex: Int) -> Int {
        return cardIndex % 5
    }

    /// Return indices of face-down cards in columns not yet used this turn.
    private func eligibleIndices(for playerIndex: Int) -> [Int] {
        let player = game.players[playerIndex]
        var indices: [Int] = []
        for i in 0..<player.cards.count {
            if !player.faceUp[i] && !columnsUsedThisTurn.contains(column(for: i)) {
                indices.append(i)
            }
        }
        return indices
    }

    // MARK: - Human Turn

    /// Highlight the human player's eligible (tappable) cards.
    private func highlightEligibleCards() {
        let playerIndex = game.currentPlayerIndex
        let eligible = eligibleIndices(for: playerIndex)
        let views = playerCardViews[playerIndex]
        for (i, cardView) in views.enumerated() {
            cardView.setHighlighted(eligible.contains(i))
        }
    }

    /// Remove all highlights from the human player's cards.
    private func clearHighlights() {
        let playerIndex = game.currentPlayerIndex
        for cardView in playerCardViews[playerIndex] {
            cardView.setHighlighted(false)
        }
    }

    // MARK: - AI Turn

    /// AI randomly flips 3 cards in different columns with a short delay between each.
    private func performAIFlipTurn() {
        let playerIndex = game.currentPlayerIndex
        let player = game.players[playerIndex]
        var usedColumns = Set<Int>()
        var pickedIndices: [Int] = []

        // Pick 3 random face-down cards in distinct columns
        var candidates = (0..<player.cards.count).filter { !player.faceUp[$0] }
        candidates.shuffle()

        for idx in candidates {
            let col = column(for: idx)
            if !usedColumns.contains(col) {
                usedColumns.insert(col)
                pickedIndices.append(idx)
                if pickedIndices.count == maxFlipsPerTurn { break }
            }
        }

        // Animate flips one by one
        for (step, idx) in pickedIndices.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(step) * 0.5) { [weak self] in
                guard let self = self else { return }
                player.revealCard(at: idx)
                self.playerCardViews[playerIndex][idx].flip()

                // After the last flip, advance turn
                if step == pickedIndices.count - 1 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        self.advanceTurn()
                    }
                }
            }
        }
    }

    private func buildPlayerBoards() {
        // Remove any existing subviews from containers
        topContainer.subviews.forEach { $0.removeFromSuperview() }
        bottomContainer.subviews.forEach { $0.removeFromSuperview() }
        playerCardViews.removeAll()
        playerIconViews.removeAll()
        playerScoreLabels.removeAll()

        // Calculate card sizes to fit on screen
        // Each player section = headerHeight + 2*cardHeight + cardSpacing
        // Available height is split proportionally between containers
        let safeHeight = view.safeAreaLayoutGuide.layoutFrame.height > 0
            ? view.safeAreaLayoutGuide.layoutFrame.height
            : view.bounds.height - 80  // estimate if not laid out yet
        let pileH: CGFloat = 60
        let spacing: CGFloat = 8  // vertical spacing between sections
        let totalPlayers = opponentCount + 1
        let availableHeight = safeHeight - pileH - spacing * 2

        // Each player gets: headerRow + 2 card rows + inner spacing
        let headerHeight: CGFloat = 18
        let innerCardSpacing: CGFloat = 3
        let perPlayerHeight = availableHeight / CGFloat(totalPlayers)
        let cardRowsHeight = perPlayerHeight - headerHeight - innerCardSpacing - 4 // 4pt padding
        let cardHeight = floor(max(cardRowsHeight / 2, 20))
        let cardWidth = floor(cardHeight * 56.0 / 80.0)

        // Also limit card width so 5 cards fit horizontally
        let sidePadding: CGFloat = 16
        let hCardSpacing: CGFloat = 4
        let maxCardWidth = floor((view.bounds.width - 2 * sidePadding - 4 * hCardSpacing) / 5)
        let finalCardW = min(cardWidth, maxCardWidth)
        let finalCardH = floor(finalCardW * 80.0 / 56.0)

        // Reorder players: opponents first (indices 1..N), then human (index 0) at bottom
        // But keep arrays indexed by game player index
        // We'll place players 1..N in topContainer, player 0 in bottomContainer

        // Initialize arrays with placeholders
        playerCardViews = Array(repeating: [], count: game.players.count)
        playerIconViews = Array(repeating: UIImageView(), count: game.players.count)
        playerScoreLabels = Array(repeating: UILabel(), count: game.players.count)

        // Build opponent boards in topContainer
        var opponentY: CGFloat = 2
        for playerIndex in 1..<game.players.count {
            let player = game.players[playerIndex]
            opponentY = addPlayerBoard(
                player: player,
                playerIndex: playerIndex,
                to: topContainer,
                startY: opponentY,
                cardW: finalCardW,
                cardH: finalCardH,
                hSpacing: hCardSpacing,
                vSpacing: innerCardSpacing,
                sidePadding: sidePadding,
                headerHeight: headerHeight
            )
            opponentY += 4 // gap between opponents
        }

        // Build human board in bottomContainer
        addPlayerBoard(
            player: game.players[0],
            playerIndex: 0,
            to: bottomContainer,
            startY: 2,
            cardW: finalCardW,
            cardH: finalCardH,
            hSpacing: hCardSpacing,
            vSpacing: innerCardSpacing,
            sidePadding: sidePadding,
            headerHeight: headerHeight
        )
    }

    /// Adds a player's header + 2×5 card grid to the given container.
    /// Returns the Y position after the last card row.
    @discardableResult
    private func addPlayerBoard(
        player: Player,
        playerIndex: Int,
        to container: UIView,
        startY: CGFloat,
        cardW: CGFloat,
        cardH: CGFloat,
        hSpacing: CGFloat,
        vSpacing: CGFloat,
        sidePadding: CGFloat,
        headerHeight: CGFloat
    ) -> CGFloat {
        var currentY = startY

        // Center the card grid horizontally
        let gridWidth = 5 * cardW + 4 * hSpacing
        let gridLeading = (view.bounds.width - gridWidth) / 2

        // Player icon
        let iconView = UIImageView()
        let iconConfig = UIImage.SymbolConfiguration(pointSize: 14, weight: .medium)
        iconView.image = UIImage(systemName: player.icon, withConfiguration: iconConfig)
        iconView.tintColor = .systemBlue
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(iconView)
        playerIconViews[playerIndex] = iconView

        // Player name
        let nameLabel = UILabel()
        nameLabel.text = player.name
        nameLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(nameLabel)

        // Score label
        let scoreLabel = UILabel()
        let totalScore = playerIndex < game.totalScores.count ? game.totalScores[playerIndex] : 0
        scoreLabel.text = "Score: \(totalScore)"
        scoreLabel.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        scoreLabel.textColor = .lightGray
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(scoreLabel)
        playerScoreLabels[playerIndex] = scoreLabel

        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: container.topAnchor, constant: currentY),
            iconView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: gridLeading),
            iconView.widthAnchor.constraint(equalToConstant: 18),
            iconView.heightAnchor.constraint(equalToConstant: 18),

            nameLabel.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 4),

            scoreLabel.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: container.leadingAnchor, constant: gridLeading + gridWidth),
        ])

        currentY += headerHeight

        // Build 2 rows × 5 columns of cards
        var cardViewsForPlayer: [CardView] = []

        for row in 0..<2 {
            for col in 0..<5 {
                let cardIndex = row * 5 + col
                let card = player.cards[cardIndex]
                let isFaceUp = player.faceUp[cardIndex]

                let cardView = CardView()
                cardView.translatesAutoresizingMaskIntoConstraints = false
                cardView.configure(with: card, faceUp: isFaceUp)
                container.addSubview(cardView)

                let xOffset = gridLeading + CGFloat(col) * (cardW + hSpacing)
                let yOffset = currentY + CGFloat(row) * (cardH + vSpacing)

                NSLayoutConstraint.activate([
                    cardView.topAnchor.constraint(equalTo: container.topAnchor, constant: yOffset),
                    cardView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: xOffset),
                    cardView.widthAnchor.constraint(equalToConstant: cardW),
                    cardView.heightAnchor.constraint(equalToConstant: cardH),
                ])

                let pIdx = playerIndex
                let idx = cardIndex
                cardView.onTap = { [weak self] in
                    guard let self = self else { return }
                    guard self.game.currentPlayerIndex == pIdx else { return }
                    self.humanCardTapped(at: idx)
                }

                cardViewsForPlayer.append(cardView)
            }
        }

        playerCardViews[playerIndex] = cardViewsForPlayer
        currentY += 2 * cardH + vSpacing
        return currentY
    }

    // MARK: - Interaction

    private func humanCardTapped(at index: Int) {
        guard !inputLocked else { return }

        let playerIndex = game.currentPlayerIndex
        let player = game.players[playerIndex]

        if game.phase == .initialFlip {
            // Initial flip phase — same column-restriction logic
            guard !player.faceUp[index] else { return }
            let col = column(for: index)
            guard !columnsUsedThisTurn.contains(col) else { return }

            player.revealCard(at: index)
            playerCardViews[playerIndex][index].flip()
            playerCardViews[playerIndex][index].setHighlighted(false)
            columnsUsedThisTurn.insert(col)
            cardsFlippedThisTurn += 1

            if cardsFlippedThisTurn >= maxFlipsPerTurn {
                clearHighlights()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { [weak self] in
                    self?.advanceTurn()
                }
            } else {
                highlightEligibleCards()
            }
        } else if awaitingCardPlacement {
            // Main phase — player is placing the drawn card
            handleCardPlacement(at: index)
        }
    }

    // MARK: - Actions

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateBackgroundImage()
        }
    }

    private func updateBackgroundImage() {
        if let img = UIImage(named: "oak_background") {
            backgroundImageView.image = img
        } else if let img = UIImage(named: "oak_background.jpg") {
            backgroundImageView.image = img
        } else if let path = Bundle.main.path(forResource: "oak_background", ofType: "jpg"),
                  let img = UIImage(contentsOfFile: path) {
            backgroundImageView.image = img
        } else {
            backgroundImageView.backgroundColor = .brown
        }
    }

    @objc private func quitTapped() {
        dismiss(animated: true)
    }
}
