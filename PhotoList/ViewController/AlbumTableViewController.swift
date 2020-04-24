//
//  AlbumTableViewController.swift
//  PhotoList
//
//  Created by Robert Moryson on 20/04/2020.
//  Copyright © 2020 Robert Moryson. All rights reserved.
//

import UIKit
import SafariServices

class AlbumTableViewController: UITableViewController {

    let networkManager = AlbumNetworkManager()
    var albums: [AlbumModel]?
    var photos: [PhotoModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    func loadData() {
        showLoadingSpinner()
        
        networkManager.fetchAlbumsAndPhotos { (albums, photos) in
            self.albums = albums
            self.photos = photos
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                
                //zamknięcie okna ładowania
                if let vc = self.presentedViewController, vc is UIAlertController { self.dismiss(animated: false, completion: nil) }
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
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let albums = albums else { return 0 }
        return albums.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellID: String
        if indexPath.row%2 == 0 {
            cellID = "RightPhotoCell"
        } else {
            cellID = "LeftPhotoCell"
        }
        
        let currentRow = realRowForMultipleSections(with: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PhotoTableViewCell
        cell.photoName.text = photos?[currentRow].title
        networkManager.fetchThumbnail(url: (photos?[currentRow].thumbnailUrl)!) { image in
            DispatchQueue.main.async {
                cell.photo.image = image
            }
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentRow = realRowForMultipleSections(with: indexPath)
        
        let url = URL(string: photos![currentRow].url)
        let vc = SFSafariViewController(url: url!)
        present(vc, animated: true, completion: nil)
    }
    
    func realRowForMultipleSections(with indexPath: IndexPath) -> Int {
        var currentRow = 0
        for section in 0..<indexPath.section {
                currentRow += tableView.numberOfRows(inSection: section)
        }
        currentRow += indexPath.row
        
        return currentRow
    }

}
