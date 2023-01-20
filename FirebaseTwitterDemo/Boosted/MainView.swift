//
//  MainView.swift
//  FirebaseTwitterDemo
//
//  Created by Alex Nagy on 20.01.2023.
//

import SwiftUI
import FirebaseService

struct MainView: View {
    
    @FirebaseAuthenticator private var auth
    
    var body: some View {
        VStack {
            Button("Logout") {
                logout()
            }
        }
    }
    
    func logout() {
        do {
            try _auth.context.signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
