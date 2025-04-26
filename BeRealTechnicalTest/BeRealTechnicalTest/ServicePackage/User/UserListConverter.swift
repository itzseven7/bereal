//
//  UserListConverter.swift
//  BeRealTechnicalTest
//
//  Created by Romain Dubreucq on 26/04/2025.
//

import Foundation

struct UserListConverter {
    static func convert(userList: DecodableUserList) throws -> UserList {
        return UserList(
            pages: try userList.pages.map({ page in
                UserPage(
                    users: try page.users.map({ user in
                        guard let url = URL(string: user.profilePictureUrl) else {
                            throw Self.Error.invalidProfileURL
                        }
                        
                        return User(
                            id: user.id,
                            name: user.name,
                            profilePictureURL: url
                        )
                    })
                )
            })
        )
    }
    
    enum Error: Swift.Error {
        case invalidProfileURL
    }
}
