//
//  DTO's.swift
//  
//
//  Created by Enes İşler on 4.07.2023.
//

import Foundation


public struct MusicResult: Decodable {
    public let resultCount: Int?
    public let results: [Music]?
}


public struct Music: Decodable {
    public let artistName: String?
    public let trackName: String?
    public let previewURL: String?
    public let artworkUrl100: String?

    public enum CodingKeys: String, CodingKey {
        case artistName, trackName
        case previewURL = "previewUrl"
        case artworkUrl100
    }
}

