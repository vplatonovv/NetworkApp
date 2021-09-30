//
//  EpisodesViewController.swift
//  NetworkApp
//
//  Created by Слава Платонов on 29.09.2021.
//

import UIKit

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
        1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        BreakingBadEpisodes.getSeasons(seasons: episodes).count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        let season = BreakingBadEpisodes.getSeasons(seasons: episodes)[indexPath.item]
        let image = seasonImages[indexPath.item]
        cell.backgroundColor = .lightGray
        cell.layer.cornerRadius = 20
        cell.configureCell(with: "Season: \(season)", image: image)
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

// MARK: UICollectionViewDelegateFlowLayout

extension EpisodesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 20, bottom: 40, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        30
    }
}
