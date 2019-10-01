//
//  PictureDetailViewController.swift
//  Persistence-Lab
//
//  Created by Eric Widjaja on 10/1/19.
//  Copyright © 2019 Eric Widjaja. All rights reserved.
//

import UIKit

class PictureDetailViewController: UIViewController {
    
    //MARK: Property & IBOutlets
    
    var picture: Photos?
    
    
    @IBOutlet weak var detailImage: UIImageView!
    
    
    private func loadDetails() {
        guard let detailPic = picture else {return}
        ImageHelper.manager.getImage(urlString: detailPic.largeImageURL) { (result) in
            DispatchQueue.main.async {
            switch result {
            case .success(let image):
                self.detailImage.image = image
            case .failure(let error):
                print(error)
                }
            }
        }
        
    }
    
    
    override func viewDidLoad() {
        loadDetails()
        super.viewDidLoad()

    }
}
