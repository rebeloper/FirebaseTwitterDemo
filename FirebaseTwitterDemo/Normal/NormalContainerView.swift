//
//  NormalContainerView.swift
//  FirebaseTwitterDemo
//
//  Created by Alex Nagy on 20.01.2023.
//

import SwiftUI



struct NormalContainerView: View {
    
    @StateObject private var authState = NormalAuthState()
    
    var body: some View {
        Group {
            switch authState.value {
            case .undefined:
                ProgressView()
            case .notAuthenticated:
                NormalAuthView()
                    .environmentObject(authState)
            case .authenticated:
                NormalMainView()
                    .environmentObject(authState)
            }
        }
    }
}

struct NormalContainerView_Previews: PreviewProvider {
    static var previews: some View {
        NormalContainerView()
    }
}
