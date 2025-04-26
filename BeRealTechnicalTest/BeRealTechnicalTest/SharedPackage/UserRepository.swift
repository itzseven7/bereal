//
//  UserRepository.swift
//  BeRealTechnicalTest
//
//  Created by Romain Dubreucq on 26/04/2025.
//

import Foundation

public protocol UserRepository {
    func getUsersList() async throws -> UserList
}
