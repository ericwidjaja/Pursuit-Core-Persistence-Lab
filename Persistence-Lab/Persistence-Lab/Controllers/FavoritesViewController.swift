//
//  FavoritesViewController.swift
//  Persistence-Lab
//
//  Created by Eric Widjaja on 10/1/19.
//  Copyright © 2019 Eric Widjaja. All rights reserved.
//

import UIKit

class FavoritesViewController: UIViewController {
    var favePhotos = [Photos]() {
            didSet {
                favTableView.reloadData()
            }
        }
        @IBOutlet weak var favTableView: UITableView!
        
        private func setDelegates() {
            favTableView.delegate = self
            favTableView.dataSource = self
        }
        private func loadFavPhotos() {
            do {
                favePhotos = try PhotoPersistenceHelper.manager.getPhotos()
            } catch {
                print(error)
            }
        }
        override func viewDidLoad() {
            super.viewDidLoad()
            setDelegates()
            
        }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            loadFavPhotos()
        }
        

        
        // MARK: - Navigation

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            guard let destination = segue.destination as? PictureDetailViewController, let indexPath = favTableView.indexPathForSelectedRow else {return}
            destination.picture = favePhotos[indexPath.row]
        }
    }

    extension FavoritesViewController: UITableViewDelegate,UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return favePhotos.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = favTableView.dequeueReusableCell(withIdentifier: "faveCell", for: indexPath) as? FavoriteTableViewCell else {
                return UITableViewCell()
            }
            let fav = favePhotos[indexPath.row]
            ImageHelper.manager.getImage(urlString: fav.previewURL) { (result) in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let image):
                    DispatchQueue.main.async {
                        cell.faveImageView.image = image
                    }
                }
            }
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 135
        }
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return "                                  My  FaVe  "
        }
    }
