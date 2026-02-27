//
//  LoginViewController.swift
//  Ripple
//
//  Created on 2/26/26.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - UI Elements

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome"
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.textAlignment = .center
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign in or create an account to continue"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
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

    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Account"

        let bgImageView = UIImageView()
        bgImageView.contentMode = .scaleAspectFill
        bgImageView.clipsToBounds = true
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        let bgName = traitCollection.userInterfaceStyle == .dark ? "dark_background" : "oak_background"
        bgImageView.image = UIImage(named: bgName)
        view.addSubview(bgImageView)
        NSLayoutConstraint.activate([
            bgImageView.topAnchor.constraint(equalTo: view.topAnchor),
            bgImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bgImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bgImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(closeTapped)
        )

        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(loginButton)
        view.addSubview(signUpButton)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -12),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20),

            subtitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subtitleLabel.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -40),
            subtitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 40),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -40),

            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            loginButton.heightAnchor.constraint(equalToConstant: 54),

            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            signUpButton.heightAnchor.constraint(equalToConstant: 54),
        ])
    }

    private func setupActions() {
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
    }

    // MARK: - Actions

    @objc private func closeTapped() {
        dismiss(animated: true)
    }

    @objc private func loginTapped() {
        let loginFormVC = LoginFormViewController()
        navigationController?.pushViewController(loginFormVC, animated: true)
    }

    @objc private func signUpTapped() {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}
