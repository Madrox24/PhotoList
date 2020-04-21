//
//  AlbumNetworkManager.swift
//  PhotoList
//
//  Created by Robert Moryson on 20/04/2020.
//  Copyright © 2020 Robert Moryson. All rights reserved.
//

import UIKit

class AlbumNetworkManager : NetworkManagerProtocol {
    func fetchAlbums(completion: @escaping ([AlbumModel]) -> ()) {
        let API_URL = "https://jsonplaceholder.typicode.com/albums"

        guard let url = URL(string: API_URL) else { return }
        
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
        guard let data = data else { return }

            do {
                let albums = try JSONDecoder().decode([AlbumModel].self, from: data)
                completion(albums)
            } catch {
                 print(error)
            }

        }.resume()
    }
    
    func fetchPhotos(completion: @escaping ([PhotoModel]) -> ()) {
        let API_URL = "https://jsonplaceholder.typicode.com/photos"
        
        guard let url = URL(string: API_URL) else { return }
        
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }

            do {
                let photos = try JSONDecoder().decode([PhotoModel].self, from: data)
                completion(photos)
            } catch {
                 print(error)
            }

        }.resume()
    }
    
    func fetchThumbnail(url: String, completion: @escaping (UIImage) -> ()) {
        
        guard let url = URL(string: url) else { return }
        
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data else { return }

            let downloadedImage = UIImage(data: data)
            completion(downloadedImage!)

        }.resume()
    }
    
}

enum jsonType {
    case photo
    case album
}
