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
    
    func fetchAlbumsAndPhotos(completion: @escaping ([AlbumModel], [PhotoModel]) -> ()) {
        let group = DispatchGroup()
        
        var albums: [AlbumModel] = []
        var photos: [PhotoModel] = []
        
        group.enter()
        fetchAlbums { albumsData in
            albums = albumsData
            group.leave()
        }
        
        group.enter()
        fetchPhotos { photosData in
            photos = photosData
            group.leave()
        }

        // Add the observer when all the tasks in the group are completed.
        group.notify(queue: .main) {
            completion(albums, photos)
        }
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
