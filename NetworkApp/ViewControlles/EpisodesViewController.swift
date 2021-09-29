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
        tabBarItem.title = "Episodes"
        tabBarItem.image = UIImage(systemName: "video.fill")
        self.collectionView!.register(CollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        fetchDataWithAlamofire()
        collectionView.backgroundColor = .white
    }
    
    func fetchDataWithAlamofire() {
        AF.request(Links.episodes.rawValue)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let json = value as? [[String: Any]] else { return }
                    for model in json {
                        let episode = BreakingBadEpisodes(
                            title: model["title"] as? String,
                            season: model["season"] as? String,
                            airDate: model["air_date"] as? String,
                            characters: model["characters"] as? [String],
                            episode: model["episode"] as? String
                        )
                        self.episodes.append(episode)
                    }
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                case .failure(let error):
                    print(error)
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
        navigationController?.pushViewController(detailEpisodeVc, animated: true)
    }
  

}

extension EpisodesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}
