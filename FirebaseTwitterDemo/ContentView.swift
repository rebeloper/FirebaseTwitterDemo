//
//  ContentView.swift
//  FirebaseTwitterDemo
//
//  Created by Alex Nagy on 20.01.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var normal = false
    
    var body: some View {
        Group {
            if normal {
                NormalContainerView()
            } else {
                ContainerView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
