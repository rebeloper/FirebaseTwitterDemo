//
//  ContainerView.swift
//  FirebaseTwitterDemo
//
//  Created by Alex Nagy on 20.01.2023.
//

import SwiftUI
import FirebaseService

struct ContainerView: View {
    
    @StateObject private var authState = AuthState()
    
    var body: some View {
        Group {
            switch authState.value {
            case .undefined:
                ProgressView()
            case .notAuthenticated:
                AuthView()
            case .authenticated:
                MainView()
            }
        }
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
}
