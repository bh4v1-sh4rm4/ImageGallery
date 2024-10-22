//
//  PhotoModel.swift
//  ImageGallery
//
//  Created by Bhavishya Sharma on 22/10/24.
//

import Foundation


struct User: Codable {
    let id: String?
    let username: String?
    let name: String
    let profileImage: ProfileImage
    let links: UserLinks
    let totalLikes: Int?
    let totalPhotos: Int?
    let bio: String?
    let updatedAt : String?
    let first_name : String?
    let last_name : String?
    let twitter_username: String?
    let portfolio_url : String?
    let location: String?
    let instagram_username: String?
    let total_collections: Int?
    let total_prompted_photos: Int?
    let total_illustrations: Int?
    let total_prompted_illustrations: Int?
    let accepted_tos: Bool?
    let for_hire: Bool?
    let socials: SocialPlatforms?
    
    enum CodingKeys: String, CodingKey {
        case id, username, name, links, bio, first_name, last_name,twitter_username,portfolio_url, location, instagram_username,total_collections, total_prompted_photos, total_illustrations, total_prompted_illustrations, accepted_tos, for_hire, socials
        case profileImage = "profile_image"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
        case updatedAt = "updated_at"
    }
}

struct SocialPlatforms : Codable {
    let instagram_username: String?
    let portfolio_url: String?
    let twitter_username: String?
    let paypal_email: String?
}

struct ProfileImage: Codable {
    let small: String?
    let medium: String?
    let large: String?
}

struct UserLinks: Codable {
    let selfLink: String?
    let html: String?
    let download: String?
    let download_location: String?
    let photos: String?
    let likes: String?
    let portfolio: String?
    let following: String?
    let followers: String?
    
    enum CodingKeys: String, CodingKey {
        case selfLink = "self"
        case html, photos, likes, portfolio, following, followers, download, download_location
    }
}

struct Photo: Codable {
    let id: String?
    let slug: String?
    let createdAt: String?
    let updatedAt: String?
    let prompted_at: String?
    let width: Int?
    let height: Int?
    let color: String?
    let blurHash: String?
    let description: String?
    let altDescription: String?
    let urls: PhotoURLs?
    let links: UserLinks?
    let likes: Int?
    let liked_by_user: Bool?
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case id, slug, prompted_at, description, links, liked_by_user
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case width, height, color
        case blurHash = "blur_hash"
        case altDescription = "alt_description"
        case urls, likes, user
    }
}

struct PhotoURLs: Codable {
    let raw: String?
    let full: String?
    let regular: String?
    let small: String?
    let thumb: String?
    let small_s3: String?
}

struct SearchPhotosResponse: Codable {
    let total: Int?
    let totalPages: Int?
    let results: [Photo]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

struct PhotoResponse: Codable {
    let results: [Photo]?
}
