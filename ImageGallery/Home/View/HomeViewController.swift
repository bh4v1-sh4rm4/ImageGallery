//
//  HomeViewController.swift
//  ImageGallery
//
//  Created by Bhavishya Sharma on 20/10/24.
//

import Foundation
import UIKit

class HomeViewController : UIViewController {
    @IBOutlet var circularLoader: UIActivityIndicatorView!
    @IBOutlet var cvImage: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    var photos : [Photo] = []
    var searchPhotos : [Photo] = []
    var viewModel = HomeViewModel()
    var isSearched : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCV()
        fetchPhotos()
        self.navigationController?.isNavigationBarHidden = true
        self.searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
    }
    
    private func setupCV() {
        cvImage.delegate = self
        cvImage.dataSource = self
        cvImage.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
        //        let layout = UICollectionViewFlowLayout()
    }
    func fetchPhotos() {
        circularLoader.startAnimating()
        viewModel.fetchPhotos { [weak self] result in
            DispatchQueue.main.async {
                self?.circularLoader.stopAnimating()
                self?.circularLoader.hidesWhenStopped = true
            }
            switch result {
            case .success(let photos):
                DispatchQueue.main.async {
                    self?.photos = photos
                    self?.cvImage.reloadData()
                }
            case .failure(let error):
                print("Error fetching photos: \(error.localizedDescription)")
            }
        }
    }
}
extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearched {
            return searchPhotos.count
        } else {
            return photos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else {return ImageCollectionViewCell()}
        var photoData : Photo?
        if isSearched {
            photoData = searchPhotos[indexPath.item]
        } else {
            photoData = photos[indexPath.item]
        }
        collectionCell.configure(imageURL: photoData!.urls.regular, profileURL: photoData!.user.profileImage.large, name: photoData!.user.name, username: photoData!.user.username, likesCount: String(photoData!.likes), commentsCount: String(photoData!.likes))
//        self.cvImage.reloadData()
        return collectionCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (collectionView.frame.width - 10)
        let height =  (collectionView.frame.width - 10 )
            return CGSize(width: width, height: height)
    }
    
}

extension HomeViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearched = true
        
        circularLoader.startAnimating()
        
        viewModel.searchPhotos(query: searchBar.text ?? "") { [weak self] result in
            
            switch result {
            case .success(let photos):
                DispatchQueue.main.async {
                    self?.searchPhotos = photos
                    self?.cvImage.reloadData()
                    self?.circularLoader.stopAnimating()
                    self?.circularLoader.hidesWhenStopped
                    self?.cvImage.reloadData()
                }
                
            case .failure(let error):
                print("Error fetching searched photos: \(error.localizedDescription)")
            }
        }
    }
    
//    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
//        <#code#>
//    }
}

