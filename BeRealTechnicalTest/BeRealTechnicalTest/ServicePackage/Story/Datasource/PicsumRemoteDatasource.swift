//
//  PicsumRemoteDatasource.swift
//  BeRealTechnicalTest
//
//  Created by Romain Dubreucq on 26/04/2025.
//

import Foundation

protocol StoryRemoteDatasource {
    func getNewStories(count: Int) async throws -> [Data]
}

struct PicsumRemoteDatasource: StoryRemoteDatasource {
    let session: URLSessionProtocol = URLSession.shared
    let screenSize: CGSize
    
    func getNewStories(count: Int) async throws -> [Data] {
        var images: [Data] = []

        try await withThrowingTaskGroup(of: Data.self) { group in
            for _ in 0..<count {
                group.addTask {
                    try await fetchNewImages(width: Int(screenSize.width), height: Int(screenSize.height))
                }
            }

            for try await image in group {
                images.append(image)
            }
        }
        
        return images
        
    }
    
    private func fetchNewImages(width: Int, height: Int) async throws -> Data {
        let builder = URLBuilder(width: width, height: height)
        let url = try builder.build()
        
        let (data, _) = try await session.data(from: url, delegate: nil)
        
        return data
    }
}

struct IdentifiableImage {
    var id: Int
    var data: Data
}

private struct URLBuilder {
    let baseURL = URL(string: "https://picsum.photos")
    
    private var width: Int
    private var height: Int
    
    init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
    
    func build() throws -> URL {
        guard let baseURL, var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            throw Self.Error.invalidBaseURL
        }
        
        guard width > 0 else {
            throw Self.Error.invalidWidth
        }
        
        guard height > 0 else {
            throw Self.Error.invalidHeight
        }
        
        var currentPath = components.path
        currentPath.append(contentsOf: "/\(width)/\(height)")
        components.path = currentPath
        
        guard let url = components.url else {
            throw Self.Error.invalidURL
        }
        
        return url
    }
    
    enum Error: Swift.Error {
        case invalidBaseURL
        case invalidWidth
        case invalidHeight
        case invalidURL
    }
}
