//
//  NormalAuthState.swift
//  FirebaseTwitterDemo
//
//  Created by Alex Nagy on 20.01.2023.
//

import SwiftUI
import FirebaseAuth

enum AuthenticatedState {
    case undefined, notAuthenticated, authenticated
}

class NormalAuthState: ObservableObject {
    @Published var value: AuthenticatedState = .undefined
    
    init() {
        Auth.auth().addStateDidChangeListener { auth, user in
            self.value = user != nil ? .authenticated : .notAuthenticated
        }
    }
    
    @MainActor
    @discardableResult
    func signUp(email: String, password: String) async throws -> AuthDataResult {
        try await Auth.auth().createUser(withEmail: email, password: password)
    }
    
    @MainActor
    @discardableResult
    func signIn(email: String, password: String) async throws -> AuthDataResult {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    @MainActor
    func logout() throws {
        try Auth.auth().signOut()
    }
}
