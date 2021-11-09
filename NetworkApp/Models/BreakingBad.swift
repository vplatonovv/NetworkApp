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
    
    static func gerCharacter(name: String, characters: [BreakingBadCharacters]) -> BreakingBadCharacters {
        var result: BreakingBadCharacters!
        for character in characters where character.name == name {
            result = character
        }
        return result
    }
}

struct BreakingBadEpisodes: Decodable {
    let title: String
    let season: String
    let airDate: String
    let characters: [String]
    let episode: String
    
    // unique json
    static func getSeasons(seasons: [BreakingBadEpisodes]) -> [String] {
        var results: [String] = []
        results = Set(seasons.map({ $0.season })).sorted(by: <)
        for (index, result) in results.enumerated() {
            if result.contains(" ") {
                results.remove(at: index)
            }
        }
        return results
    }
    
    static func getEpisodes(_ episodes: [BreakingBadEpisodes], _ season: String) -> [BreakingBadEpisodes] {
        var result: [BreakingBadEpisodes] = []
        for episode in episodes where episode.season.contains(season) {
            result.append(episode)
        }
        return result
    }
}

let seasonImages = ["season1", "season2", "season3", "season4", "season5"]


