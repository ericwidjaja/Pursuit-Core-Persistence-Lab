//
//  FirstViewController.swift
//  Persistence-Lab
//
//  Created by Eric Widjaja on 9/30/19.
//  Copyright © 2019 Eric Widjaja. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var photos = [Photos]() {
        didSet {
            picsCollectionView.reloadData()
        }
    }
    
    var searchString: String? = nil {
        didSet {
            loadPhotoSearchData()
        }
    }
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var picSearchBar: UISearchBar!
    
    @IBOutlet weak var picsCollectionView: UICollectionView!
    
    //MARK: - Functions
    private func setUpDelegates() {
        picsCollectionView.delegate = self
        picsCollectionView.dataSource = self
        picSearchBar.delegate = self
    }
    

    private func loadPhotoSearchData() {
        guard let picSearchString = searchString else  {return}
        guard searchString != "" else {return}
        let urlFromSearch = SecretAPIKey.getUrlWith(query: picSearchString); PixabayApiHelper.manager.getPixabayWrapper(urlString: urlFromSearch) {(result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let wrapper):
                DispatchQueue.main.async {
                    self.photos = wrapper.hits
                }
            }
        }
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegates()
        // Do any additional setup after loading the view.
    }


}
//MARK: - Extensions

extension FirstViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchString = searchBar.text
    }
}

extension FirstViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = picsCollectionView.dequeueReusableCell(withReuseIdentifier: "picCell", for: indexPath) as? PicCollectionViewCell else {
            return UICollectionViewCell()
        }
        let photo = photos[indexPath.row]
        ImageHelper.manager.getImage(urlString: photo.webformatURL) { (result) in
            switch result {
                case .failure(let error):
                    print(error)
            case .success(let image):
                DispatchQueue.main.async {
                    cell.picImageView.image = image
                }
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
}


