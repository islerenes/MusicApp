//
//  ViewController.swift
//  MusicApp
//
//  Created by Enes İşler on 4.07.2023.
//

import UIKit
import MusicAPI

class ViewController: UIViewController, LoadingShowable {
    
    let service : MusicServiceProtocol = MusicService()
    var music : [Music] = []
    var searchMusic = [String]()
    @IBOutlet weak var Search: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MusicCell", bundle: nil), forCellReuseIdentifier: "Cell")
        tableView.register(cellType: MusicCell.self)
        fetchMusic("Simge")
    }
    
    
    fileprivate func fetchMusic(_ word : String) {
        self.showLoading()
        service.fetchMusic(word) { [weak self] result in
            guard let self else { return }
            self.hideLoading()
            switch result {
            case .success(let music):
                self.music = music
                tableView.reloadData()
            case .failure(let error):
                print("ERROR" ,error)
            }
        }
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.showsCancelButton = true
        if !searchText.isEmpty {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
                self?.fetchMusic(searchText)
                self?.tableView.reloadData()
            })
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = nil
        searchBar.resignFirstResponder()
        let firstIndexPath = IndexPath(row: 0, section: 0)
        tableView.selectRow(at: firstIndexPath, animated: true, scrollPosition: .top)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        let firstIndexPath = IndexPath(item: 0, section: 0)
        tableView.reloadData()
        return true
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return music.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeCell(cellType: MusicCell.self, indexPath: indexPath)
        let music = self.music[indexPath.row]
        cell.configure(music: music)
        
        return cell
    }
    
}
