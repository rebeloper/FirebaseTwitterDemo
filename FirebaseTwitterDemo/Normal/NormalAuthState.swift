//
//  NormalAuthState.swift
//  FirebaseTwitterDemo
//
//  Created by Alex Nagy on 20.01.2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

enum AuthenticatedState {
    case undefined, notAuthenticated, authenticated
}

class NormalAuthState: ObservableObject {
    @Published var value: AuthenticatedState = .undefined
    
    @Published var profile: Profile = Profile(uid: "", name: "")
    
    init() {
        Auth.auth().addStateDidChangeListener { auth, user in
            self.value = user != nil ? .authenticated : .notAuthenticated
            if user != nil {
                let uid = user!.uid
                Task {
                    do {
                        try await self.fetchProfile(uid: uid)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    @MainActor
    func signUp(name: String, email: String, password: String) async throws {
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        let uid = authDataResult.user.uid
        let profile = Profile(uid: authDataResult.user.uid, name: name)
        let reference = Firestore.firestore().collection("profiles").document(uid)
        do {
            self.profile = try await reference.getDocument(as: Profile.self)
        } catch {
            if error._code == 4865 {
                let reference = Firestore.firestore().collection("profiles").document(uid)
                try reference.setData(from: profile)
                self.profile = profile
            } else {
                throw error
            }
        }
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
    
    @MainActor
    func fetchProfile(uid: String) async throws {
        let reference = Firestore.firestore().collection("profiles").document(uid)
        self.profile = try await reference.getDocument(as: Profile.self)
    }
}
