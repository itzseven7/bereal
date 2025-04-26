//
//  UserList.swift
//  BeRealTechnicalTest
//
//  Created by Romain Dubreucq on 26/04/2025.
//

import Foundation

public struct UserPage {
    public let users: [User]
    
    public init(users: [User]) {
        self.users = users
    }
}

public struct UserList {
    public let pages: [UserPage]
    
    public init(pages: [UserPage]) {
        self.pages = pages
    }
}
