//
//  FirstViewController.swift
//  Persistence-Lab
//
//  Created by Eric Widjaja on 9/30/19.
//  Copyright © 2019 Eric Widjaja. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    //MARK: - Properties

    var searchResults = [Photos]() {
        didSet {
            picsCollectionView.reloadData()}
    }
    
//    var searchString: String? = nil {
//        didSet {
//            loadPhotoSearchData()}
//    }
//
    
    //MARK: - IBOutlets
    @IBOutlet weak var picSearchBar: UISearchBar!
    
    @IBOutlet weak var picsCollectionView: UICollectionView!
    
    //MARK: - Functions
    private func setUpDelegates() {
        picsCollectionView.delegate = self
        picsCollectionView.dataSource = self
        picSearchBar.delegate = self
    }
    private func loadPhotoSearchData(str: String) {
        PixabayApiHelper.manager.getPixabayWrapper(str: str) {(result) in
            DispatchQueue.main.async {
            switch result {
            case .failure(let error):
                print(error)
            case .success(let results):
                
                self.searchResults = results.hits
                }
            }
        }
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        setUpDelegates()
        super.viewDidLoad()
    }
}


//MARK: - Extensions

extension FirstViewController: UISearchBarDelegate {
func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    var searchString = searchBar.text ?? ""
    searchString = searchString.lowercased().replacingOccurrences(of: " ", with: "+")
    loadPhotoSearchData(str: searchString)
    print(searchString)
    }
}
    
extension FirstViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = picsCollectionView.dequeueReusableCell(withReuseIdentifier: "picCell", for: indexPath) as? PicCollectionViewCell else {
            return UICollectionViewCell()}
        let photo = searchResults[indexPath.row]
        ImageHelper.manager.getImage(urlString: photo.previewURL) { (result) in
            DispatchQueue.main.async {
            switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    cell.picImageView.image = image
                    print("image load successfully")
                }
            }
        }
        return cell
    }
}


