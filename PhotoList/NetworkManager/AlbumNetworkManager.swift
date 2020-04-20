//
//  AlbumNetworkManager.swift
//  PhotoList
//
//  Created by Robert Moryson on 20/04/2020.
//  Copyright © 2020 Robert Moryson. All rights reserved.
//

import Foundation

class AlbumNetworkManager : NetworkManagerProtocol {
    func fetchAlbums(completion: @escaping ([AlbumModel]) -> ()) {
        let API_URL = "https://jsonplaceholder.typicode.com/albums"

        guard let url = URL(string: API_URL) else { return }
        
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
        guard let data = data else { return }

            do {
                let currentWeather = try JSONDecoder().decode([AlbumModel].self, from: data)
                completion(currentWeather)
            } catch {
                 print(error)
            }

        }.resume()
    }
    
}

