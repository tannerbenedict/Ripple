//
//  ViewController.swift
//  Ripple
//
//  Created on 2/26/26.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - UI Elements

    private let titleImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private let soloPlayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Solo Play", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let playWithFriendsButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Play with Friends", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.backgroundColor = .systemIndigo
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let profileButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 28, weight: .medium)
        let image = UIImage(systemName: "person.circle", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let friendsButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 28, weight: .medium)
        let image = UIImage(systemName: "person.2.fill", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }

    // MARK: - Setup

    private let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        return iv
    }()

    override var prefersHomeIndicatorAutoHidden: Bool { true }

    private func setupUI() {
        view.backgroundColor = .black
        view.insetsLayoutMarginsFromSafeArea = false

        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        updateBackgroundImage()

        view.addSubview(titleImageView)
        view.addSubview(soloPlayButton)
        view.addSubview(playWithFriendsButton)
        view.addSubview(profileButton)
        view.addSubview(friendsButton)

        NSLayoutConstraint.activate([
            profileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            profileButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            profileButton.widthAnchor.constraint(equalToConstant: 44),
            profileButton.heightAnchor.constraint(equalToConstant: 44),

            friendsButton.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 8),
            friendsButton.trailingAnchor.constraint(equalTo: profileButton.trailingAnchor),
            friendsButton.widthAnchor.constraint(equalToConstant: 44),
            friendsButton.heightAnchor.constraint(equalToConstant: 44),

            titleImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            titleImageView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.4),
            titleImageView.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.35),

            soloPlayButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            soloPlayButton.bottomAnchor.constraint(equalTo: playWithFriendsButton.topAnchor, constant: -12),
            soloPlayButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            soloPlayButton.heightAnchor.constraint(equalToConstant: 50),

            playWithFriendsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            playWithFriendsButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            playWithFriendsButton.widthAnchor.constraint(equalTo: soloPlayButton.widthAnchor),
            playWithFriendsButton.heightAnchor.constraint(equalTo: soloPlayButton.heightAnchor),
        ])
    }

    private func setupActions() {
        soloPlayButton.addTarget(self, action: #selector(soloPlayTapped), for: .touchUpInside)
        playWithFriendsButton.addTarget(self, action: #selector(playWithFriendsTapped), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(profileTapped), for: .touchUpInside)
        friendsButton.addTarget(self, action: #selector(friendsTapped), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc private func profileTapped() {
        let destination: UIViewController
        if AuthManager.shared.isLoggedIn {
            destination = ProfileViewController()
        } else {
            destination = LoginViewController()
        }
        let nav = UINavigationController(rootViewController: destination)
        present(nav, animated: true)
    }

    @objc private func friendsTapped() {
        // TODO: Navigate to friends list screen
    }

    private var selectedOpponentCount = 1

    @objc private func soloPlayTapped() {
        selectedOpponentCount = 1

        let alert = UIAlertController(
            title: "Solo Play",
            message: "Choose number of opponents",
            preferredStyle: .actionSheet
        )

        for count in 1...5 {
            let title = count == 1 ? "1 Opponent" : "\(count) Opponents"
            alert.addAction(UIAlertAction(title: title, style: .default) { [weak self] _ in
                self?.selectedOpponentCount = count
                self?.showPlayConfirmation(opponentCount: count)
            })
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        // iPad support
        if let popover = alert.popoverPresentationController {
            popover.sourceView = soloPlayButton
            popover.sourceRect = soloPlayButton.bounds
        }

        present(alert, animated: true)
    }

    private func showPlayConfirmation(opponentCount: Int) {
        let opponentText = opponentCount == 1 ? "1 opponent" : "\(opponentCount) opponents"
        let alert = UIAlertController(
            title: "Ready?",
            message: "Play against \(opponentText)",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Play", style: .default) { [weak self] _ in
            self?.startSoloGame(opponentCount: opponentCount)
        })

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alert, animated: true)
    }

    @objc private func playWithFriendsTapped() {
        // TODO: Navigate to play with friends mode
    }

    // MARK: - Game Launch

    private func startSoloGame(opponentCount: Int) {
        let gameVC = GameViewController(opponentCount: opponentCount)
        let nav = UINavigationController(rootViewController: gameVC)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateBackgroundImage()
        }
    }

    private func updateBackgroundImage() {
        // Try multiple loading approaches for the background image
        if let img = UIImage(named: "oak_background") {
            backgroundImageView.image = img
        } else if let img = UIImage(named: "oak_background.jpg") {
            backgroundImageView.image = img
        } else if let path = Bundle.main.path(forResource: "oak_background", ofType: "jpg"),
                  let img = UIImage(contentsOfFile: path) {
            backgroundImageView.image = img
        } else {
            // Fallback: brown color so it's obvious the image is missing
            backgroundImageView.backgroundColor = .brown
        }
        let isDark = traitCollection.userInterfaceStyle == .dark
        titleImageView.image = UIImage(named: isDark ? "whiteTitle" : "title")
    }
}
