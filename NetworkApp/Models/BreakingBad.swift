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
    let title: String
    let season: String
    let air_date: String
    let characters: [String]
    let episode: String
}