//
//  SViewController.swift
//  NetworkApp
//
//  Created by Слава Платонов on 03.10.2021.
//

import UIKit

class SViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    private var seasons: [BreakingBadEpisodes] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = . systemBackground
        configaureCollection()
        requestEpisodesWithAlamofire()
    }
    
    private func configaureCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 40, right: 20)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
        layout.minimumLineSpacing = 30
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(SeasonsCell.self, forCellWithReuseIdentifier: "season")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
    }
    
    private func requestEpisodesWithAlamofire() {
        NetworkManager.shared.fetchDataWithAlamofire(url: Links.episodes.rawValue) { [unowned self] result in
            switch result {
            case .success(let episodes):
                self.seasons = episodes
                self.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension SViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        BreakingBadEpisodes.getSeasons(seasons: seasons).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "season", for: indexPath) as! SeasonsCell
        let season = BreakingBadEpisodes.getSeasons(seasons: seasons)[indexPath.item]
        let image = seasonImages[indexPath.item]
        cell.backgroundColor = .lightGray
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.black.cgColor
        cell.configureCell(with: "Season: \(season)", image: image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let season = BreakingBadEpisodes.getSeasons(seasons: seasons)[indexPath.item]
        let episodes = BreakingBadEpisodes.getEpisodes(seasons, season)
        let episodesVc = EViewController()
        episodesVc.seasons = episodes
        episodesVc.title = "Season: \(season)"
        episodesVc.imageSeason = seasonImages[indexPath.item]
        navigationController?.pushViewController(episodesVc, animated: true)
    }
}
