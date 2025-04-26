//
//  FileUserRepository.swift
//  BeRealTechnicalTest
//
//  Created by Romain Dubreucq on 26/04/2025.
//

import Foundation

public struct FileUserRepository: UserRepository {
    private let fileURL: URL
    
    public init(fileURL: URL) {
        self.fileURL = fileURL
    }
    
    public func getUsersList() async throws -> UserList {
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            throw Self.Error.fileDoesNotExist
        }
        
        let data = try Data(contentsOf: fileURL)
        let decodedData = try JSONDecoder().decode(DecodableUserList.self, from: data)
        return try UserListConverter.convert(userList: decodedData)
    }
    
    enum Error: Swift.Error {
        case fileDoesNotExist
    }
}
