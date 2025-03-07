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
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    
    //MARK: - Functions
    private func loadDetails() {
        guard let detailImage = picture else {return}
        ImageHelper.manager.getImage(urlString: picture!.largeImageURL) { (result) in
            DispatchQueue.main.async {
            switch result {
            case .success(let image):
                self.detailImage.image = image
            case .failure(let error):
                print(error)
                }
            }
        }
        tagsLabel.text = " Tags#:  \(String(describing: detailImage.tags))"
        favoriteLabel.text = " Favorites:  \(detailImage.favorites ?? Int())"
        likesLabel.text = " 👍  \(detailImage.likes ?? Int())"
        
    }
    //MARK: - IBAction
    @IBAction func favoriteButton(_ sender: UIButton) {
        do{
            try PhotoPersistenceHelper.manager.savePhotos(newPhoto: picture!)
        }
        catch {
            print(error)
        }
    }
    
    //MARK: - Attempting to segue data
    override func viewWillAppear(_ animated: Bool) {
        dump(picture)
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetails()
        
    }
}
