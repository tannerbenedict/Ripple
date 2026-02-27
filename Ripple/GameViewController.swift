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
    private var playerBoardContainers: [UIView] = []

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
    private let quitFloatingButton = UIButton(type: .system)

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
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

        // Background image
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        updateBackgroundImage()

        // Floating quit button (top-left)
        quitFloatingButton.setTitle("✕", for: .normal)
        quitFloatingButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        quitFloatingButton.setTitleColor(.white, for: .normal)
        quitFloatingButton.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        quitFloatingButton.layer.cornerRadius = 15
        quitFloatingButton.translatesAutoresizingMaskIntoConstraints = false
        quitFloatingButton.addTarget(self, action: #selector(quitTapped), for: .touchUpInside)
        view.addSubview(quitFloatingButton)
        NSLayoutConstraint.activate([
            quitFloatingButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            quitFloatingButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            quitFloatingButton.widthAnchor.constraint(equalToConstant: 30),
            quitFloatingButton.heightAnchor.constraint(equalToConstant: 30),
        ])

        // Pile container centered on screen
        pileContainer.translatesAutoresizingMaskIntoConstraints = false
        pileContainer.backgroundColor = UIColor.secondarySystemBackground.withAlphaComponent(0.85)
        pileContainer.layer.cornerRadius = 10
        view.addSubview(pileContainer)

        NSLayoutConstraint.activate([
            pileContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pileContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pileContainer.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.4),
            pileContainer.heightAnchor.constraint(equalToConstant: 60),
        ])

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

    /// Assign players to screen edges clockwise: bottom (human), left, top, right.
    private func edgeAssignments() -> (bottom: [Int], left: [Int], top: [Int], right: [Int]) {
        let opps = Array(1..<game.players.count)
        switch opps.count {
        case 0:  return ([0], [], [], [])
        case 1:  return ([0], [], opps, [])
        case 2:  return ([0], [opps[0]], [], [opps[1]])
        case 3:  return ([0], [opps[0]], [opps[1]], [opps[2]])
        case 4:  return ([0], [opps[0]], [opps[1], opps[2]], [opps[3]])
        case 5:  return ([0], [opps[1], opps[0]], [opps[2]], [opps[3], opps[4]])
        default: return ([0], [], opps, [])
        }
    }

    private func buildPlayerBoards() {
        // Remove existing boards
        playerBoardContainers.forEach { $0.removeFromSuperview() }
        playerBoardContainers.removeAll()
        playerCardViews.removeAll()
        playerIconViews.removeAll()
        playerScoreLabels.removeAll()

        let totalPlayers = game.players.count
        playerCardViews = Array(repeating: [], count: totalPlayers)
        playerIconViews = Array(repeating: UIImageView(), count: totalPlayers)
        playerScoreLabels = Array(repeating: UILabel(), count: totalPlayers)

        let screenW = view.bounds.width
        let screenH = view.bounds.height
        let safe = view.safeAreaInsets

        let edges = edgeAssignments()
        let hasLeft = !edges.left.isEmpty
        let hasRight = !edges.right.isEmpty
        let hasTop = !edges.top.isEmpty

        // Side zones: 22% of screen width when occupied
        let sideZoneW: CGFloat = (hasLeft || hasRight) ? screenW * 0.22 : 0
        let centerW = screenW - (hasLeft ? sideZoneW : 0) - (hasRight ? sideZoneW : 0)

        // Pile is centered; zones fill the space above/below
        let pileH: CGFloat = 60
        let pileGap: CGFloat = 8
        let pileMidY = screenH / 2
        let topZoneH = pileMidY - pileH / 2 - pileGap - safe.top
        let bottomZoneH = screenH - safe.bottom - (pileMidY + pileH / 2 + pileGap)

        let headerH: CGFloat = 18
        let vSp: CGFloat = 3
        let hSp: CGFloat = 4
        let pad: CGFloat = 6

        // Compute card and board sizes for a given zone
        func sizeForZone(zoneW: CGFloat, zoneH: CGFloat, playersWide: Int = 1, playersHigh: Int = 1)
            -> (cardW: CGFloat, cardH: CGFloat, boardW: CGFloat, boardH: CGFloat) {
            let perW = zoneW / CGFloat(max(playersWide, 1))
            let perH = zoneH / CGFloat(max(playersHigh, 1))
            var ch = floor((perH - headerH - vSp - pad * 2) / 2)
            var cw = floor(ch * 56.0 / 80.0)
            let maxCW = floor((perW - pad * 2 - 4 * hSp) / 5)
            if cw > maxCW { cw = maxCW; ch = floor(cw * 80.0 / 56.0) }
            ch = max(ch, 16); cw = max(floor(ch * 56.0 / 80.0), 12)
            let gw = 5 * cw + 4 * hSp
            let gh = 2 * ch + vSp
            return (cw, ch, gw + pad * 2, headerH + gh + pad * 2)
        }

        let btm = sizeForZone(zoneW: centerW, zoneH: bottomZoneH)
        let topSz = hasTop
            ? sizeForZone(zoneW: centerW, zoneH: topZoneH, playersWide: edges.top.count)
            : (cardW: CGFloat(0), cardH: CGFloat(0), boardW: CGFloat(0), boardH: CGFloat(0))
        let maxSideStack = max(edges.left.count, edges.right.count, 1)
        let sideAvailH = screenH - safe.top - safe.bottom
        let sideSz = (hasLeft || hasRight)
            ? sizeForZone(zoneW: sideZoneW, zoneH: sideAvailH, playersHigh: maxSideStack)
            : (cardW: CGFloat(0), cardH: CGFloat(0), boardW: CGFloat(0), boardH: CGFloat(0))

        // Build a board view for one player
        func makeBoard(playerIndex: Int, cw: CGFloat, ch: CGFloat, bw: CGFloat, bh: CGFloat) -> UIView {
            let container = UIView(frame: CGRect(x: 0, y: 0, width: bw, height: bh))
            container.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            container.layer.cornerRadius = 8

            let player = game.players[playerIndex]

            let iconView = UIImageView()
            let iconCfg = UIImage.SymbolConfiguration(pointSize: 12, weight: .medium)
            iconView.image = UIImage(systemName: player.icon, withConfiguration: iconCfg)
            iconView.tintColor = .systemBlue
            iconView.contentMode = .scaleAspectFit
            iconView.frame = CGRect(x: pad, y: pad, width: 16, height: 16)
            container.addSubview(iconView)
            playerIconViews[playerIndex] = iconView

            let nameLabel = UILabel()
            nameLabel.text = player.name
            nameLabel.font = UIFont.systemFont(ofSize: 11, weight: .bold)
            nameLabel.textColor = .white
            nameLabel.frame = CGRect(x: pad + 20, y: pad, width: bw - pad * 2 - 80, height: 16)
            container.addSubview(nameLabel)

            let scoreLabel = UILabel()
            scoreLabel.text = "Score: \(game.totalScores[playerIndex])"
            scoreLabel.font = UIFont.systemFont(ofSize: 10, weight: .regular)
            scoreLabel.textColor = .lightGray
            scoreLabel.textAlignment = .right
            scoreLabel.frame = CGRect(x: bw - pad - 60, y: pad, width: 60, height: 16)
            container.addSubview(scoreLabel)
            playerScoreLabels[playerIndex] = scoreLabel

            var cardViews: [CardView] = []
            let gridStartY = pad + headerH
            for row in 0..<2 {
                for col in 0..<5 {
                    let cardIndex = row * 5 + col
                    let card = player.cards[cardIndex]
                    let isFaceUp = player.faceUp[cardIndex]

                    let cv = CardView()
                    cv.frame = CGRect(
                        x: pad + CGFloat(col) * (cw + hSp),
                        y: gridStartY + CGFloat(row) * (ch + vSp),
                        width: cw, height: ch
                    )
                    cv.configure(with: card, faceUp: isFaceUp)

                    let pIdx = playerIndex
                    let idx = cardIndex
                    cv.onTap = { [weak self] in
                        guard let self = self else { return }
                        guard self.game.currentPlayerIndex == pIdx else { return }
                        self.humanCardTapped(at: idx)
                    }
                    container.addSubview(cv)
                    cardViews.append(cv)
                }
            }
            playerCardViews[playerIndex] = cardViews
            return container
        }

        // --- Position boards around the screen edges ---
        let centerX = (hasLeft ? sideZoneW : 0) + centerW / 2

        // BOTTOM (human player)
        for playerIdx in edges.bottom {
            let board = makeBoard(playerIndex: playerIdx, cw: btm.cardW, ch: btm.cardH, bw: btm.boardW, bh: btm.boardH)
            board.center = CGPoint(x: centerX, y: screenH - safe.bottom - btm.boardH / 2 - 2)
            view.addSubview(board)
            playerBoardContainers.append(board)
        }

        // TOP (opponents across from human)
        if hasTop {
            let topTotalW = topSz.boardW * CGFloat(edges.top.count) + 10 * CGFloat(max(edges.top.count - 1, 0))
            var topX = centerX - topTotalW / 2 + topSz.boardW / 2
            let topY = safe.top + topSz.boardH / 2 + 2
            for playerIdx in edges.top {
                let board = makeBoard(playerIndex: playerIdx, cw: topSz.cardW, ch: topSz.cardH, bw: topSz.boardW, bh: topSz.boardH)
                board.center = CGPoint(x: topX, y: topY)
                view.addSubview(board)
                playerBoardContainers.append(board)
                topX += topSz.boardW + 10
            }
        }

        // LEFT (opponents on left edge, stacked vertically)
        if hasLeft {
            let leftTotalH = sideSz.boardH * CGFloat(edges.left.count) + 10 * CGFloat(max(edges.left.count - 1, 0))
            let leftX = safe.left + sideZoneW / 2
            var leftY = (screenH - leftTotalH) / 2 + sideSz.boardH / 2
            for playerIdx in edges.left {
                let board = makeBoard(playerIndex: playerIdx, cw: sideSz.cardW, ch: sideSz.cardH, bw: sideSz.boardW, bh: sideSz.boardH)
                board.center = CGPoint(x: leftX, y: leftY)
                view.addSubview(board)
                playerBoardContainers.append(board)
                leftY += sideSz.boardH + 10
            }
        }

        // RIGHT (opponents on right edge, stacked vertically)
        if hasRight {
            let rightTotalH = sideSz.boardH * CGFloat(edges.right.count) + 10 * CGFloat(max(edges.right.count - 1, 0))
            let rightX = screenW - safe.right - sideZoneW / 2
            var rightY = (screenH - rightTotalH) / 2 + sideSz.boardH / 2
            for playerIdx in edges.right {
                let board = makeBoard(playerIndex: playerIdx, cw: sideSz.cardW, ch: sideSz.cardH, bw: sideSz.boardW, bh: sideSz.boardH)
                board.center = CGPoint(x: rightX, y: rightY)
                view.addSubview(board)
                playerBoardContainers.append(board)
                rightY += sideSz.boardH + 10
            }
        }

        // Bring pile and quit button to front
        view.bringSubviewToFront(pileContainer)
        view.bringSubviewToFront(quitFloatingButton)
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
