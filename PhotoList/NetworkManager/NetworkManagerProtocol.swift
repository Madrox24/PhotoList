//
//  NetworkManagerProtocol.swift
//  PhotoList
//
//  Created by Robert Moryson on 20/04/2020.
//  Copyright © 2020 Robert Moryson. All rights reserved.
//

import UIKit

protocol NetworkManagerProtocol {
    func fetchAlbums(completion: @escaping ([AlbumModel]) -> ())
    func fetchPhotos(completion: @escaping ([PhotoModel]) -> ())
    func fetchThumbnail(url: String, completion: @escaping (UIImage) -> ())
    func fetchAlbumsAndPhotos(completion: @escaping ([AlbumModel], [PhotoModel]) -> ())
}
