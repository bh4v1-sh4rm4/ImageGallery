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
    var searchPhotos : PhotoResponse?
    var viewModel = HomeViewModel()
    var isSearched : Bool = false
    var refreshControl = UIRefreshControl()
    
    //MARK: - UI Lifecycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCV()
        fetchPhotos()
        setupUI()
    }
    
    // MARK: - UI Setup Methods
    
    private func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
        self.searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
               view.addGestureRecognizer(tapGesture)
        setupRefreshControl()
    }
    
    private func setupCV() {
        cvImage.delegate = self
        cvImage.dataSource = self
        cvImage.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
    }
    private func setupRefreshControl() {
        if #available(iOS 10.0, *) {
            cvImage.refreshControl = refreshControl
        } else {
            cvImage.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    // MARK: - OBJC Function for UI Handeling
    
    @objc private func refreshData() {
        fetchPhotos()
        circularLoader.startAnimating()
        circularLoader.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            // Stop the refresh control
            self.refreshControl.endRefreshing()
            self.cvImage.reloadData()
            self.circularLoader.stopAnimating()
            self.circularLoader.hidesWhenStopped = true
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - IBAction Methods
    
    @IBAction func btnActionLogout(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - User Defined Methods
    
    private func showErrorDialog(error: String) {
        DispatchQueue.main.async{
            let alert = UIAlertController(title: error, message: "Try Again?", preferredStyle: .alert)
            let retryAction = UIAlertAction(title: "Retry", style: .default) { _ in
                self.fetchPhotos()
                self.dismiss(animated: true)
            }
            let exitAction = UIAlertAction(title: "Logout", style: .destructive) { _ in
                self.dismiss(animated: true)
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(exitAction)
            alert.addAction(retryAction)
            self.present(alert, animated: true, completion: nil)
        }
        
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
                self?.showErrorDialog(error: error.localizedDescription)
                print("Error fetching photos: \(error.localizedDescription)")
            }
        }
    }
}

// MARK: - Extension: UI TableView Delegate Methods

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearched {
            return searchPhotos?.results?.count ?? 0
        } else {
            return photos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else {return ImageCollectionViewCell()}
        var photoData : Photo?
        if isSearched {
            photoData = searchPhotos?.results?[indexPath.item]
        } else {
            photoData = photos[indexPath.item]
        }
        collectionCell.configure(imageURL: photoData!.urls?.regular, profileURL: photoData?.user.profileImage.large, name: photoData?.user.name, username: photoData?.user.username, likesCount: String(photoData?.likes ?? 0), commentsCount: String(photoData?.likes ?? 0))
        return collectionCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (collectionView.frame.width - 10)
        let height =  (collectionView.frame.width - 10 )
            return CGSize(width: width, height: height)
    }
    
}

// MARK: - Extension : UI SearchBar Delegate

extension HomeViewController : UISearchBarDelegate {
    internal func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
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
                self?.showErrorDialog(error: error.localizedDescription)
                print("Error fetching searched photos: \(error.localizedDescription)")
            }
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
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
                self?.showErrorDialog(error: error.localizedDescription)
                print("Error fetching searched photos: \(error.localizedDescription)")
            }
        }
    }
}

