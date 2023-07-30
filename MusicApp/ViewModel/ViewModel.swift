//
//  ViewModel.swift
//  MusicApp
//
//  Created by Enes İşler on 4.07.2023.
//

import Foundation
/*import MusicAPI


protocol ViewModelDelegate: AnyObject {
    func showLoadingView()
    func hideLoadingView()
    func reloadData()
}

final class ViewModel {
    
    private var music: [Music] = []
    let service : MusicServiceProtocol
    weak var delegate: ViewModelDelegate?
    
    init(service: MusicServiceProtocol) {
        self.service = service
    }
    
    fileprivate func fetchMusic(_ music : String) {
        
        self.delegate?.showLoadingView()
        service.fetchMusic(music) { [weak self] response in
            guard let self else { return }
            self.delegate?.hideLoadingView()
            switch response {
            case .success(let music):
                print(music)
                self.delegate?.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}*/

