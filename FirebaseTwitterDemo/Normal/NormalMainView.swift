//
//  NormalMainView.swift
//  FirebaseTwitterDemo
//
//  Created by Alex Nagy on 20.01.2023.
//

import SwiftUI

struct NormalMainView: View {
    
    @EnvironmentObject private var authState: NormalAuthState
    
    var body: some View {
        VStack {
            Button("Logout") {
                logout()
            }
        }
    }
    
    func logout() {
        do {
            try authState.logout()
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct NormalMainView_Previews: PreviewProvider {
    static var previews: some View {
        NormalMainView()
    }
}
