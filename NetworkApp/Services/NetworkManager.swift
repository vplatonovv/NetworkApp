//
//  NetworkManager.swift
//  NetworkApp
//
//  Created by Слава Платонов on 29.09.2021.
//

import Foundation
import Alamofire

enum Links: String {
    case characters = "https://www.breakingbadapi.com/api/characters"
    case episodes = "https://www.breakingbadapi.com/api/episodes?series=Breaking+Bad"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fecthData<T: Decodable>(dataType: T.Type, from url: String, with completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let typeData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(typeData))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImage(from url: String?) -> Data? {
        guard let stringURL = url else { return nil }
        guard let imageURL = URL(string: stringURL) else { return nil }
        return try? Data(contentsOf: imageURL)
    }
    
    func fetchDataWithAlamofire(url: String, complition: @escaping(Result<[BreakingBadEpisodes], NetworkError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let json = value as? [[String: Any]] else { return }
                    var episodes: [BreakingBadEpisodes] = []
                    for model in json {
                        let episode = BreakingBadEpisodes(
                            title: model["title"] as? String,
                            season: model["season"] as? String,
                            airDate: model["air_date"] as? String,
                            characters: model["characters"] as? [String],
                            episode: model["episode"] as? String
                        )
                        episodes.append(episode)
                    }
                    DispatchQueue.main.async {
                        complition(.success(episodes))
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}
