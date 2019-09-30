//
//  Pixabay.swift
//  Persistence-Lab
//
//  Created by Eric Widjaja on 9/30/19.
//  Copyright © 2019 Eric Widjaja. All rights reserved.
//

import Foundation

// MARK: - Pixabay
struct Pixabay {
    let totalHits: Int
    let hits: [Hit]
    let total: Int
}

// MARK: - Hit
struct Hit {
    let largeImageURL: String
    let webformatHeight, webformatWidth, likes, imageWidth: Int
    let id, userID, views, comments: Int
    let pageURL: String
    let imageHeight: Int
    let webformatURL: String
    let type: String
    let previewHeight: Int
    let tags: String
    let downloads: Int
    let user: String
    let favorites, imageSize, previewWidth: Int
    let userImageURL, previewURL: String
}
