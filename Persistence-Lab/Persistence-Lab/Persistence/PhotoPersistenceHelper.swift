//
//  PhotoPersistenceHelper.swift
//  Persistence-Lab
//
//  Created by Eric Widjaja on 10/1/19.
//  Copyright © 2019 Eric Widjaja. All rights reserved.
//

import Foundation

class PhotoPersistenceHelper {
    static let manager = PhotoPersistenceHelper ()
    
    func savePhotos(newPhoto: Photos) throws {
        
        try persistenceHelper.save(newElement: newPhoto)
    }
    let persistenceHelper = PersistenceHelper<Photos>(fileName: "savedPhotos.plist")
    
    func getPhotos() throws -> [Photos] {
        return try persistenceHelper.getObjects()
    }
    private init (){}
}
