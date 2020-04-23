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
        let count = photos.filter { $0.albumId == section + 1 }.count
        return count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return albums?[section].title
        //let index = albums!.firstIndex(where: { $0.id == photos![indexPath.row].albumId })
        //cell.albumName.text = albums?[index!].title
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let albums = albums else { return 0 }
        return albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellID: String
        if indexPath.row%2 == 0 {
            cellID = "PhotoCell"
        } else {
            cellID = "PhotoCell2"
        }
        
        var currentRow = 0
        for section in 0..<indexPath.section {
                currentRow += tableView.numberOfRows(inSection: section)
        }
        currentRow += indexPath.row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PhotoTableViewCell
        cell.photoName.text = photos?[currentRow].title
        networkManager.fetchThumbnail(url: (photos?[currentRow].thumbnailUrl)!) { image in
            DispatchQueue.main.async {
                cell.photo.image = image
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

}
