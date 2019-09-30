//
//  PixabayWrapper.swift
//  Persistence-Lab
//
//  Created by Eric Widjaja on 9/30/19.
//  Copyright © 2019 Eric Widjaja. All rights reserved.
//

import Foundation
import UIKit


// MARK: - Pixabay
struct PixabayWrapper: Codable {
    let hits: [Photos]
}

// MARK: - Hit
struct Photos: Codable {
    let largeImageURL: String
    let likes: Int?
    let favorites: Int?
    let tags: String
    let previewURL: String
    let webformatURL: String
}

