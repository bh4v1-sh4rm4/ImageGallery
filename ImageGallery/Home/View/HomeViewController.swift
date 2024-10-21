//
//  HomeViewController.swift
//  ImageGallery
//
//  Created by Bhavishya Sharma on 20/10/24.
//

import Foundation
import UIKit

struct Photo: Decodable {
    let id: String
    let slug: String
    let alternativeSlugs: AlternativeSlugs? // Optional
    let createdAt: String
    let updatedAt: String
    let promotedAt: String?
    let width: Int
    let height: Int
    let color: String
    let blurHash: String
    let description: String?
    let altDescription: String?
    let urls: PhotoURLs
    let links: PhotoLinks
    let likes: Int
    let likedByUser: Bool
    let sponsorship: Sponsorship?
    let user: User

    // Map the JSON keys to the correct Swift properties
    enum CodingKeys: String, CodingKey {
        case id
        case slug
        case alternativeSlugs = "alternative_slugs" // Maps to alternative_slugs
        case createdAt = "created_at"               // Maps to created_at
        case updatedAt = "updated_at"               // Maps to updated_at
        case promotedAt = "promoted_at"
        case width
        case height
        case color
        case blurHash = "blur_hash"                 // Maps to blur_hash
        case description
        case altDescription = "alt_description"     // Maps to alt_description
        case urls
        case links
        case likes
        case likedByUser = "liked_by_user"          // Maps to liked_by_user
        case sponsorship
        case user
    }
}

struct AlternativeSlugs: Decodable {
    let en: String
    let es: String
    let ja: String
    let fr: String
    let it: String
    let ko: String
    let de: String
    let pt: String
}

struct PhotoURLs: Decodable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
    let smallS3: String

    enum CodingKeys: String, CodingKey {
        case raw
        case full
        case regular
        case small
        case thumb
        case smallS3 = "small_s3" // Maps to small_s3
    }
}

struct PhotoLinks: Decodable {
    let selfLink: String
    let html: String
    let download: String
    let downloadLocation: String

    enum CodingKeys: String, CodingKey {
        case selfLink = "self"  // Maps to self
        case html
        case download
        case downloadLocation = "download_location" // Maps to download_location
    }
}

struct Sponsorship: Decodable {
    let impressionUrls: [String]
    let tagline: String
    let taglineUrl: String
    let sponsor: Sponsor

    enum CodingKeys: String, CodingKey {
        case impressionUrls = "impression_urls"   // Maps to impression_urls
        case tagline
        case taglineUrl = "tagline_url"           // Maps to tagline_url
        case sponsor
    }
}

struct Sponsor: Decodable {
    let id: String
    let updatedAt: String
    let username: String
    let name: String
    let firstName: String
    let lastName: String
    let portfolioUrl: String?
    let bio: String?
    let location: String?
    let profileImage: ProfileImage
    let instagramUsername: String?

    enum CodingKeys: String, CodingKey {
        case id
        case updatedAt = "updated_at"
        case username
        case name
        case firstName = "first_name"
        case lastName = "last_name"
        case portfolioUrl = "portfolio_url"
        case bio
        case location
        case profileImage = "profile_image"
        case instagramUsername = "instagram_username"
    }
}

struct User: Decodable {
    let id: String
    let updatedAt: String
    let username: String
    let name: String
    let firstName: String
    let lastName: String
    let portfolioUrl: String?
    let bio: String?
    let profileImage: ProfileImage
    let social: Social?

    enum CodingKeys: String, CodingKey {
        case id
        case updatedAt = "updated_at"
        case username
        case name
        case firstName = "first_name"
        case lastName = "last_name"
        case portfolioUrl = "portfolio_url"
        case bio
        case profileImage = "profile_image"
        case social
    }
}

struct ProfileImage: Decodable {
    let small: String
    let medium: String
    let large: String
}

struct Social: Decodable {
    let instagramUsername: String?
    let portfolioUrl: String?
    let twitterUsername: String?

    enum CodingKeys: String, CodingKey {
        case instagramUsername = "instagram_username"
        case portfolioUrl = "portfolio_url"
        case twitterUsername = "twitter_username"
    }
}

class HomeViewController : UIViewController {
    @IBOutlet var circularLoader: UIActivityIndicatorView!
    @IBOutlet var cvImage: UICollectionView!
    @IBOutlet var searchBar: UISearchBar!
    var photos : [Photo] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCV()
        fetchPhotos()
        self.navigationController?.isNavigationBarHidden = true
        self.searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
    }
    
    func setupCV() {
        cvImage.delegate = self
        cvImage.dataSource = self
        cvImage.register(UINib(nibName: "ImageCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCollectionViewCell")
//        let layout = UICollectionViewFlowLayout()
    }
    
    func fetchPhotos() {
        let clientID = "naFg1XfPR1-Pn2ru7JBVg2d5pjanCpI58rdSrGfMdnE"
        let urlString = "https://api.unsplash.com/photos/?client_id=\(clientID)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        // Start the loader before the request
        circularLoader.startAnimating()
        
        // Perform the API call asynchronously
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            // Stop the loader after the request
            DispatchQueue.main.async {
                self?.circularLoader.stopAnimating()
                self?.circularLoader.hidesWhenStopped = true
            }
            
            if let error = error {
                print("Error making API call: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Invalid response from the server")
                return
            }
            
            guard let data = data else {
                print("No data received from the server")
                return
            }
            
            do {
                // Decode the JSON data
                let decodedPhotos = try JSONDecoder().decode([Photo].self, from: data)
                
                // Update the photos array and reload the collection view on the main thread
                DispatchQueue.main.async {
                    self?.photos = decodedPhotos
                    self?.cvImage.reloadData() // Reload the collection view with the new data
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}
extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell else {return ImageCollectionViewCell()}
        var photoData = photos[indexPath.item]
        collectionCell.configure(imageURL: photoData.urls.regular, profileURL: photoData.user.profileImage.large, name: photoData.user.name, username: photoData.user.username)
                
        return collectionCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = (collectionView.frame.width - 10)
        let height =  (collectionView.frame.width - 10 )
            return CGSize(width: width, height: height)
    }
    
}

extension HomeViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        true
    }
}

