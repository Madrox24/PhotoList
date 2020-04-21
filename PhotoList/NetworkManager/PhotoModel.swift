//
//  PhotoModel.swift
//  PhotoList
//
//  Created by Robert Moryson on 21/04/2020.
//  Copyright © 2020 Robert Moryson. All rights reserved.
//

import Foundation

struct PhotoModel: Codable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}
