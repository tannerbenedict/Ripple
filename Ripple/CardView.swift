//
//  CardView.swift
//  Ripple
//
//  Created on 2/26/26.
//

import UIKit

/// A view that displays a single Ripple game card.
class CardView: UIView {

    // MARK: - Properties

    private let cardBackImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "cardBack")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    private let cardFaceImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.isHidden = true
        return iv
    }()
    private(set) var isFaceUp: Bool = false
    private var card: Card?

    /// Called when the card is tapped.
    var onTap: (() -> Void)?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Setup

    private func setupView() {
        backgroundColor = .systemBlue
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.separator.cgColor
        clipsToBounds = true

        // Card back image (shown when face-down)
        addSubview(cardBackImageView)
        NSLayoutConstraint.activate([
            cardBackImageView.topAnchor.constraint(equalTo: topAnchor),
            cardBackImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardBackImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardBackImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        // Card face image (shown when face-up)
        addSubview(cardFaceImageView)
        NSLayoutConstraint.activate([
            cardFaceImageView.topAnchor.constraint(equalTo: topAnchor),
            cardFaceImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardFaceImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardFaceImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true

        showFaceDown()
    }

    // MARK: - Configuration

    /// Configure the card view with a card.
    func configure(with card: Card, faceUp: Bool) {
        self.card = card
        self.isFaceUp = faceUp

        if faceUp {
            showFaceUp()
        } else {
            showFaceDown()
        }
    }

    /// Flip the card face-up with animation.
    func flip() {
        guard !isFaceUp else { return }
        isFaceUp = true

        UIView.transition(with: self, duration: 0.3, options: .transitionFlipFromLeft) {
            self.showFaceUp()
        }
    }

    // MARK: - Highlight

    /// Show or hide a white highlight border to indicate the card is selectable.
    func setHighlighted(_ highlighted: Bool) {
        if highlighted {
            layer.borderWidth = 3
            layer.borderColor = UIColor.white.cgColor
        } else {
            layer.borderWidth = 1
            layer.borderColor = UIColor.separator.cgColor
        }
    }

    // MARK: - Display

    private func showFaceDown() {
        backgroundColor = .clear
        cardBackImageView.isHidden = false
        cardFaceImageView.isHidden = true
    }

    private func showFaceUp() {
        guard let card = card else { return }
        cardBackImageView.isHidden = true
        cardFaceImageView.isHidden = false

        let imageName: String
        switch card {
        case .number(let value):
            imageName = "\(value)"
        case .ripple:
            imageName = "0"
        }
        cardFaceImageView.image = UIImage(named: imageName)
        backgroundColor = .clear
    }

    // MARK: - Actions

    @objc private func tapped() {
        onTap?()
    }
}
