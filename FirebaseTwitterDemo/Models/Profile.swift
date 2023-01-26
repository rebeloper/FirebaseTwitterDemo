//
//  Profile.swift
//  FirebaseTwitterDemo
//
//  Created by Alex Nagy on 26.01.2023.
//

import Foundation
import FirebaseService

struct Profile: Codable & Firestorable & Equatable {
    var uid: String
    var name: String
}
