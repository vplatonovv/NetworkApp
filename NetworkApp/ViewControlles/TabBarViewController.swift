//
//  TabBarViewController.swift
//  NetworkApp
//
//  Created by Слава Платонов on 25.09.2021.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var characters: [BreakingBadCharacters] = []
    var episodes: [BreakingBadEpisodes] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        requestCharacets()
        requestEpisodes()
    }
    
    private func requestCharacets() {
        guard let url = URL(string: "https://www.breakingbadapi.com/api/characters") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "error not found")
                return
            }
            do {
                let json = try JSONDecoder().decode([BreakingBadCharacters].self, from: data)
                DispatchQueue.main.async {
                    self.characters = json
                    self.postDataCharacters()
                    print("my characters - \(String(describing: self.characters))")
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    private func requestEpisodes() {
        guard let url = URL(string: "https://www.breakingbadapi.com/api/episodes") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "error not found")
                return
            }
            do {
                let json = try JSONDecoder().decode([BreakingBadEpisodes].self, from: data)
                DispatchQueue.main.async {
                    self.episodes = json
                    self.postDataEpisodes()
                    print("my episodes - \(String(describing: self.episodes))")
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    private func postDataCharacters() {
        let characterListVC = viewControllers?.first as! CharacterListViewController
        characterListVC.characters = characters
    }
    
    private func postDataEpisodes() {
        let episodesListVC = viewControllers?.last as! EpisodesListViewController
        episodesListVC.episodes = episodes
    }
}
