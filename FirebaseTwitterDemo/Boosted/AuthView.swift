//
//  AuthView.swift
//  FirebaseTwitterDemo
//
//  Created by Alex Nagy on 20.01.2023.
//

import SwiftUI
import FirebaseService

struct AuthView: View {
    
    @FirebaseAuthenticator<Profile> private var auth
    
    @State private var isSignedUp = true
    
    @State private var name = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            if isSignedUp != true {
                TextField("Name", text: $name)
                    .textFieldStyle(.roundedBorder)
            }
            
            TextField("Email", text: _auth.$context.credentials.email)
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Password", text: _auth.$context.credentials.password)
                .textFieldStyle(.roundedBorder)
            
            Group {
                if isSignedUp {
                    Button("Sign in") {
                        signIn()
                    }
                } else {
                    Button("Sign up") {
                        signUp()
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            
            Button("\(isSignedUp ? "I don't have an account" : "Already have an account")") {
                isSignedUp.toggle()
            }
            
        }
        .padding()
    }
    
    func signIn() {
        Task {
            do {
                try await _auth.context.signIn()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func signUp() {
        Task {
            do {
                let profile = Profile(uid: "", name: name)
                try await _auth.context.signUp(profile: profile)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
