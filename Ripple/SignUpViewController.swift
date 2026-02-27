//
//  SignUpViewController.swift
//  Ripple
//
//  Created on 2/26/26.
//

import UIKit

class SignUpViewController: UIViewController {

    // MARK: - UI Elements

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create Account"
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.textAlignment = .center
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
        field.borderStyle = .roundedRect
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.keyboardType = .emailAddress
        field.returnKeyType = .next
        field.font = UIFont.systemFont(ofSize: 17)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Username"
        field.borderStyle = .roundedRect
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .next
        field.font = UIFont.systemFont(ofSize: 17)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.borderStyle = .roundedRect
        field.isSecureTextEntry = true
        field.returnKeyType = .next
        field.font = UIFont.systemFont(ofSize: 17)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private let confirmPasswordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Confirm Password"
        field.borderStyle = .roundedRect
        field.isSecureTextEntry = true
        field.returnKeyType = .done
        field.font = UIFont.systemFont(ofSize: 17)
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemRed
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        title = "Sign Up"

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

        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)

        view.addSubview(titleLabel)
        view.addSubview(emailField)
        view.addSubview(usernameField)
        view.addSubview(passwordField)
        view.addSubview(confirmPasswordField)
        view.addSubview(errorLabel)
        view.addSubview(signUpButton)

        let fieldHeight: CGFloat = 50

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20),

            emailField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            emailField.heightAnchor.constraint(equalToConstant: fieldHeight),

            usernameField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 16),
            usernameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            usernameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            usernameField.heightAnchor.constraint(equalToConstant: fieldHeight),

            passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 16),
            passwordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            passwordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            passwordField.heightAnchor.constraint(equalToConstant: fieldHeight),

            confirmPasswordField.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16),
            confirmPasswordField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            confirmPasswordField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            confirmPasswordField.heightAnchor.constraint(equalToConstant: fieldHeight),

            errorLabel.topAnchor.constraint(equalTo: confirmPasswordField.bottomAnchor, constant: 12),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),

            signUpButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 20),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            signUpButton.heightAnchor.constraint(equalToConstant: 54),
        ])

        emailField.delegate = self
        usernameField.delegate = self
        passwordField.delegate = self
        confirmPasswordField.delegate = self
    }

    private func setupActions() {
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
    }

    // MARK: - Validation

    private func validateFields() -> Bool {
        errorLabel.text = ""

        guard let email = emailField.text, !email.isEmpty else {
            errorLabel.text = "Please enter your email."
            return false
        }

        guard email.contains("@") && email.contains(".") else {
            errorLabel.text = "Please enter a valid email address."
            return false
        }

        guard let username = usernameField.text, !username.isEmpty else {
            errorLabel.text = "Please enter a username."
            return false
        }

        guard let password = passwordField.text, !password.isEmpty else {
            errorLabel.text = "Please enter a password."
            return false
        }

        guard password.count >= 6 else {
            errorLabel.text = "Password must be at least 6 characters."
            return false
        }

        guard let confirmPassword = confirmPasswordField.text, !confirmPassword.isEmpty else {
            errorLabel.text = "Please confirm your password."
            return false
        }

        guard password == confirmPassword else {
            errorLabel.text = "Passwords do not match."
            return false
        }

        return true
    }

    // MARK: - Actions

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func signUpTapped() {
        guard validateFields() else { return }

        let email = emailField.text ?? ""
        let password = passwordField.text ?? ""

        AuthManager.shared.signUp(email: email, password: password) { [weak self] success in
            if success {
                // Dismiss all the way back to the home screen
                self?.presentingViewController?.dismiss(animated: true)
            }
        }
    }
}

// MARK: - UITextFieldDelegate

extension SignUpViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailField:
            usernameField.becomeFirstResponder()
        case usernameField:
            passwordField.becomeFirstResponder()
        case passwordField:
            confirmPasswordField.becomeFirstResponder()
        case confirmPasswordField:
            confirmPasswordField.resignFirstResponder()
            signUpTapped()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
