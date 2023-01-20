//
//  NormalAuthView.swift
//  FirebaseTwitterDemo
//
//  Created by Alex Nagy on 20.01.2023.
//

import SwiftUI

struct NormalAuthView: View {
    
    @EnvironmentObject private var authState: NormalAuthState
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var isSignedUp = true
    
    var body: some View {
        VStack {
            Spacer()
            
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Password", text: $password)
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
                try await authState.signIn(email: email, password: password)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func signUp() {
        Task {
            do {
                try await authState.signUp(email: email, password: password)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct NormalAuthView_Previews: PreviewProvider {
    static var previews: some View {
        NormalAuthView()
    }
}
