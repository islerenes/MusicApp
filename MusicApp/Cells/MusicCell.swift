//
//  MusicCell.swift
//  MusicApp
//
//  Created by Enes İşler on 4.07.2023.
//

import UIKit
import MusicAPI
import SDWebImage
import AVFoundation
import AVFAudio

class MusicCell: UITableViewCell {
    
    
    
    @IBOutlet weak var imageSong: UIImageView!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var songName: UILabel!
    
    var songUrl: String = ""
    
    var player: AVAudioPlayer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    func configure(music: Music) {
        preparePosterImage(with: music.artworkUrl100)
        self.artistName.text = music.artistName
        songName.text = music.trackName
        songUrl = music.previewURL!
    }
    
    private func preparePosterImage(with urlString: String?) {
        let fullPath = urlString
        if let url = URL(string: fullPath! ) {
            imageSong.sd_setImage(with: url)
        }
        
    }
    
    static var audioPlayer: AVAudioPlayer?
        private var audioDataTask: URLSessionDataTask?

        func fetchAudio(for urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
            guard let audioURL = URL(string: urlString) else {
                let error = NSError(domain: "not URL", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            let session = URLSession.shared
            audioDataTask?.cancel()
            audioDataTask = session.dataTask(with: audioURL) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let audioData = data else {
                    let error = NSError(domain: "Data Error", code: 0, userInfo: nil)
                    completion(.failure(error))
                    return
                }
                completion(.success(audioData))
            }
            audioDataTask?.resume()
        }
    
    func playAudio(for urlString: String) {
        if let audioPlayer = MusicCell.audioPlayer {
            if audioPlayer.isPlaying {
                
                audioPlayer.pause()
            } else {
                audioPlayer.play()
            }
        } else {
            fetchAudio(for: urlString) { [weak self] result in
                switch result {
                case .success(let audioData):
                    DispatchQueue.main.async {
                        do {
                            MusicCell.audioPlayer = try AVAudioPlayer(data: audioData)
                            MusicCell.audioPlayer?.prepareToPlay()
                            MusicCell.audioPlayer?.play()
                        } catch {
                            print("Audio player error: \(error.localizedDescription)")
                        }
                    }
                case .failure(let error):
                    print("Audio data fetch error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    
    @IBAction func playSong(_ sender: UIButton) {
        var urlString = songUrl
        print("abc",urlString)
        playAudio(for:urlString )
        
        
        
       /* if let player = player, player.isPlaying {
            player.stop()
        }
        
        else {
            var urlString = Bundle.main.path(forResource: "audio", ofType: "mp4")
            urlString = songUrl
            
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true)
                
                guard let urlString = urlString else { return }
                
                print("abc",urlString)
                
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                guard let player = player else { return }
                player.play()
            }
            
            catch {
                
                print("something went wrong")
                
            }
        }*/
    }
    
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
