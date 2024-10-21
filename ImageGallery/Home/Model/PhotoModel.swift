//
//  PhotoModel.swift
//  ImageGallery
//
//  Created by Bhavishya Sharma on 22/10/24.
//

import Foundation

// Base model for User
struct User: Codable {
    let id: String
    let username: String
    let name: String
    let profileImage: ProfileImage
    let links: UserLinks
    let totalLikes: Int
    let totalPhotos: Int
    
    enum CodingKeys: String, CodingKey {
        case id, username, name, links
        case profileImage = "profile_image"
        case totalLikes = "total_likes"
        case totalPhotos = "total_photos"
    }
}

// Profile Image for User
struct ProfileImage: Codable {
    let small: String
    let medium: String
    let large: String
}

// User Links
struct UserLinks: Codable {
    let selfLink: String
    let html: String
    let photos: String
    
    enum CodingKeys: String, CodingKey {
        case selfLink = "self"
        case html, photos
    }
}

// Photo or Search Result Model
struct Photo: Codable {
    let id: String
    let slug: String?
    let createdAt: String
    let width: Int
    let height: Int
    let color: String
    let blurHash: String
    let altDescription: String?
    let urls: PhotoURLs
    let likes: Int
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case id, slug, createdAt = "created_at", width, height, color, blurHash = "blur_hash", altDescription = "alt_description", urls, likes, user
    }
}

// Photo URLs
struct PhotoURLs: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

// Response for Search Photos
struct SearchPhotosResponse: Codable {
    let total: Int
    let totalPages: Int
    let results: [Photo]

    enum CodingKeys: String, CodingKey {
        case total
        case totalPages = "total_pages"
        case results
    }
}

// Response for Single Photo
struct PhotoResponse: Codable {
    let photo: Photo
}
