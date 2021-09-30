//
//  EpisodesViewController.swift
//  NetworkApp
//
//  Created by Слава Платонов on 29.09.2021.
//

import UIKit
import Alamofire

private let reuseIdentifier = "Cell"

class EpisodesViewController: UICollectionViewController {
    
    private var episodes: [BreakingBadEpisodes] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        requestEpisodesWithAlamofire()
    }
    
    private func requestEpisodesWithAlamofire() {
        NetworkManager.shared.fetchDataWithAlamofire(url: Links.episodes.rawValue) { result in
            switch result {
            case .success(let episodes):
                self.episodes = episodes
                self.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return episodes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        let episode = episodes.map{ $0.episode }[indexPath.item]
        let season = episodes.map { $0.season }[indexPath.item]
        cell.backgroundColor = .lightGray
        cell.layer.cornerRadius = 20
        cell.infoLabel.text = "Season: \(season ?? ""), episode: \(episode ?? "")"
        // Configure the cell
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let episode = episodes[indexPath.item]
        let detailEpisodeVc = DetailEpisodeViewController()
        detailEpisodeVc.configureDetail(with: episode)
        detailEpisodeVc.characters = episode.characters
        navigationController?.pushViewController(detailEpisodeVc, animated: true)
    }
  

}

extension EpisodesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}
