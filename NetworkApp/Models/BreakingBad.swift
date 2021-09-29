//
//  BreakingBad.swift
//  NetworkApp
//
//  Created by Слава Платонов on 24.09.2021.
//

import Foundation

struct BreakingBadCharacters: Decodable {
    let name: String
    let birthday: String
    let img: String
    let status: String
    let nickname: String
}

struct BreakingBadEpisodes: Decodable {
    let title: String?
    let season: String?
    let airDate: String?
    let characters: [String]?
    let episode: String?
    
//    init(episodes: [String: Any]) {
//        title = episodes["title"] as? String
//        season = episodes["season"] as? String
//        airDate = episodes["air_date"] as? String
//        characters = [episodes["characters"]] as? [String] // probably here error
//        episode = episodes["episode"] as? String
//    }
}
