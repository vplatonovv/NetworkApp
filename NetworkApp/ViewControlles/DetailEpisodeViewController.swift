//
//  DetailEpisodeViewController.swift
//  NetworkApp
//
//  Created by Слава Платонов on 29.09.2021.
//

import UIKit

class DetailEpisodeViewController: UIViewController {
    
    private var label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabel()
        setConstrainsLabel()
        view.backgroundColor = .white
    }
    
    func configureDetail(with episode: BreakingBadEpisodes) {
        label.text = """
    title: \(episode.title ?? ""),
    season: \(episode.season ?? ""),
    episode: \(episode.episode ?? ""),
    air date: \(episode.airDate ?? ""),
    chracters: \(episode.characters ?? [""])
    """
    }
    
    private func configureLabel() {
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(label)
    }
    
    private func setConstrainsLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
}
