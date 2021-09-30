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
    // unique json
    static func getSeasons(seasons: [BreakingBadEpisodes]) -> [String] {
        var results: [String] = []
        results = Set(seasons.map({ $0.season ?? "" })).sorted(by: <)
        for (index, result) in results.enumerated() {
            if result.contains(" ") {
                results.remove(at: index)
            }
        }
        return results
    }
}

let seasonImages = ["season1", "season2", "season3", "season4", "season5"]


