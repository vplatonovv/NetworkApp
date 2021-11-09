//
//  CharacterImageView.swift
//  NetworkApp
//
//  Created by Слава Платонов on 01.10.2021.
//

import UIKit

class CharacterImageView: UIImageView {
    func fetchImage(from url: URL) {
        
        // from cache
        if let cachedImage = getCachedImage(from: url) {
            image = cachedImage
            print("IMAGE FROM CACHE \(url)")
            return
        }
        // from network and add to cache
        NetworkManager.shared.fetchImage(from: url) { data, response in
            self.image = UIImage(data: data)
            self.saveDataToCache(with: data, and: response)
            print("IMAGE FROM NETWORK ADD TO CACHE \(response.url!)")
        }
    }
        
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let request = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
    
    private func getCachedImage(from url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            return UIImage(data: cachedResponse.data)
        }
        return nil
    }
}
