//
//  MusicResponses.swift
//  
//
//  Created by Enes İşler on 4.07.2023.
//

import Foundation

public struct MusicResponses : Decodable {
    public let results: [Music]
    
    private enum RootCodingKeys: String, CodingKey {
        case results
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootCodingKeys.self)
        self.results = try container.decode([Music].self, forKey: .results)
    }
}
