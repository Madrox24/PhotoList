//
//  ViewController.swift
//  PhotoList
//
//  Created by Robert Moryson on 20/04/2020.
//  Copyright © 2020 Robert Moryson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let networkManager = AlbumNetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        networkManager.fetchAlbums { albums in
            print(albums[0])
        }
    }


}

