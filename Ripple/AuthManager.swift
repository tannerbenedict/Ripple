//
//  AuthManager.swift
//  Ripple
//
//  Created on 2/26/26.
//

import Foundation

/// Manages user authentication state throughout the app.
class AuthManager {

    static let shared = AuthManager()

    private init() {}

    // MARK: - Properties

    /// Whether the user is currently logged in.
    private(set) var isLoggedIn: Bool = false

    /// The display name of the logged-in user.
    private(set) var username: String?

    /// The email of the logged-in user.
    private(set) var email: String?

    // MARK: - Methods

    /// Simulate a login with the given credentials.
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        // TODO: Replace with real authentication logic
        self.isLoggedIn = true
        self.email = email
        self.username = email.components(separatedBy: "@").first ?? "User"
        completion(true)
    }

    /// Simulate account creation with the given credentials.
    func signUp(email: String, password: String, completion: @escaping (Bool) -> Void) {
        // TODO: Replace with real authentication logic
        self.isLoggedIn = true
        self.email = email
        self.username = email.components(separatedBy: "@").first ?? "User"
        completion(true)
    }

    /// Log out the current user.
    func logout() {
        isLoggedIn = false
        username = nil
        email = nil
    }
}
