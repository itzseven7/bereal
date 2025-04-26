//
//  User.swift
//  BeRealTechnicalTest
//
//  Created by Romain Dubreucq on 26/04/2025.
//

import Foundation

public struct User: Identifiable, Equatable {
    public let id: Int
    public let name: String
    public let profilePictureURL: URL
    
    public init(id: Int, name: String, profilePictureURL: URL) {
        self.id = id
        self.name = name
        self.profilePictureURL = profilePictureURL
    }
}
