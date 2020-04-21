//
//  AlbumTableViewController.swift
//  PhotoList
//
//  Created by Robert Moryson on 20/04/2020.
//  Copyright © 2020 Robert Moryson. All rights reserved.
//

import UIKit

class AlbumTableViewController: UITableViewController {

    let networkManager = AlbumNetworkManager()
    var albums: [AlbumModel]?
    var photos: [PhotoModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    func loadData() {
        networkManager.fetchAlbums { albums in
            print(albums[0])
            self.albums = albums
        }
        
        networkManager.fetchPhotos { photos in
            print(photos[0])
            self.photos = photos
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let photos = photos else { return 0 }
        return photos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoTableViewCell
        let index = albums!.firstIndex(where: { $0.id == photos![indexPath.row].albumId })
        cell.albumName.text = albums?[index!].title
        cell.photoName.text = photos?[indexPath.row].title
        networkManager.fetchThumbnail(url: (photos?[indexPath.row].thumbnailUrl)!) { image in
            DispatchQueue.main.async {
                cell.photo.image = image
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 91.0
    }

}
