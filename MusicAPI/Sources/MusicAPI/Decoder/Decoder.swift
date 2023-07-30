//
//  Decoder.swift
//  
//
//  Created by Enes İşler on 4.07.2023.
//

import Foundation

public enum Decoders {
    static let dateDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
}
