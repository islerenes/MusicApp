//
//  MusicServices.swift
//  
//
//  Created by Enes İşler on 4.07.2023.
//

import Foundation
import Alamofire

public protocol MusicServiceProtocol: AnyObject {
    func fetchMusic(_ word: String ,completion: @escaping(Result<[Music], Error>) -> Void)
}

public class MusicService: MusicServiceProtocol{
    
    public init() {}
    
    public func fetchMusic(_ word: String ,completion: @escaping(Result<[Music], Error>) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=\(word)&entity=musicTrack&attribute=mixTerm"
        AF.request(urlString).responseData { response in
            switch response.result {
            case .success(let data):
                let decoder = Decoders.dateDecoder
                do {
                    let response = try decoder.decode(MusicResponses.self, from: data)
                    completion(.success(response.results))
                } catch {
                    print("************JSON DECODE ERROR************")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("************GECICI HATA ************")
                completion(.failure(error))
            }
        }
    }
}
