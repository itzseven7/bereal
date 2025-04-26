//
//  DecodableUserList.swift
//  BeRealTechnicalTest
//
//  Created by Romain Dubreucq on 26/04/2025.
//

import Foundation

struct DecodableUserList: Decodable {
    let pages: [DecodableUserPage]
    
    struct DecodableUserPage: Decodable {
        let users: [DecodableUser]
    }
    
    struct DecodableUser: Decodable {
        let id: Int
        let name: String
        let profilePictureUrl: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case profilePictureUrl = "profile_picture_url"
        }
    }
}
