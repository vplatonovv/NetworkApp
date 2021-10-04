//
//  EViewController.swift
//  NetworkApp
//
//  Created by Слава Платонов on 03.10.2021.
//

import UIKit

class EViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    var seasons: [BreakingBadEpisodes] = []
    var imageSeason: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = . systemBackground
        configaureCollection()
    }
    
    private func configaureCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 40, right: 20)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
        layout.minimumLineSpacing = 30
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.register(EpisodesCell.self, forCellWithReuseIdentifier: "episode")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
    }
}

extension EViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        seasons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "episode", for: indexPath) as! EpisodesCell
        let episodes = seasons[indexPath.item]
        cell.backgroundColor = .lightGray
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.black.cgColor
        cell.configureCell(with: episodes, and: imageSeason)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let episode = seasons[indexPath.item]
        let detailVc = DetailEpisodeViewController()
        detailVc.configureDetail(with: episode)
        detailVc.characters = episode.characters
        navigationController?.pushViewController(detailVc, animated: true)
    }
}
