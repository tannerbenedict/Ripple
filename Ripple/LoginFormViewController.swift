//
//  LoginFormViewController.swift
//  Ripple
//
//  Created on 2/26/26.
//

import UIKit

class LoginFormViewController: UIViewController {

    // MARK: - UI Elements

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Log In"
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

    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
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

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupActions()
    }

    // MARK: - Setup

    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Login"

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

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.keyboardDismissMode = .onDrag
        view.addSubview(scrollView)

        let formContainer = UIView()
        formContainer.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(formContainer)

        formContainer.addSubview(titleLabel)
        formContainer.addSubview(emailField)
        formContainer.addSubview(passwordField)
        formContainer.addSubview(errorLabel)
        formContainer.addSubview(loginButton)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            formContainer.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            formContainer.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            formContainer.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            formContainer.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            formContainer.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),

            titleLabel.topAnchor.constraint(equalTo: formContainer.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: formContainer.centerXAnchor),

            emailField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            emailField.centerXAnchor.constraint(equalTo: formContainer.centerXAnchor),
            emailField.widthAnchor.constraint(equalTo: formContainer.widthAnchor, multiplier: 0.45),
            emailField.heightAnchor.constraint(equalToConstant: 44),

            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 12),
            passwordField.centerXAnchor.constraint(equalTo: formContainer.centerXAnchor),
            passwordField.widthAnchor.constraint(equalTo: emailField.widthAnchor),
            passwordField.heightAnchor.constraint(equalTo: emailField.heightAnchor),

            errorLabel.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 8),
            errorLabel.centerXAnchor.constraint(equalTo: formContainer.centerXAnchor),
            errorLabel.widthAnchor.constraint(equalTo: emailField.widthAnchor),

            loginButton.topAnchor.constraint(equalTo: errorLabel.bottomAnchor, constant: 16),
            loginButton.centerXAnchor.constraint(equalTo: formContainer.centerXAnchor),
            loginButton.widthAnchor.constraint(equalTo: emailField.widthAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.bottomAnchor.constraint(equalTo: formContainer.bottomAnchor, constant: -20),
        ])

        emailField.delegate = self
        passwordField.delegate = self
    }

    private func setupActions() {
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
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

        guard let password = passwordField.text, !password.isEmpty else {
            errorLabel.text = "Please enter your password."
            return false
        }

        return true
    }

    // MARK: - Actions

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc private func loginTapped() {
        guard validateFields() else { return }

        let email = emailField.text ?? ""
        let password = passwordField.text ?? ""

        AuthManager.shared.login(email: email, password: password) { [weak self] success in
            if success {
                // Dismiss all the way back to the home screen
                self?.presentingViewController?.dismiss(animated: true)
            } else {
                self?.errorLabel.text = "Invalid email or password."
            }
        }
    }
}

// MARK: - UITextFieldDelegate

extension LoginFormViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case emailField:
            passwordField.becomeFirstResponder()
        case passwordField:
            passwordField.resignFirstResponder()
            loginTapped()
        default:
            textField.resignFirstResponder()
        }
        return true
    }
}
