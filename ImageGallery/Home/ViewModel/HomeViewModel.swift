//
//  HomeViewModel.swift
//  ImageGallery
//
//  Created by Bhavishya Sharma on 22/10/24.
//

import Foundation

class HomeViewModel {
    private let clientID = "naFg1XfPR1-Pn2ru7JBVg2d5pjanCpI58rdSrGfMdnE"
    
    func fetchPhotos(completion: @escaping (Result<[Photo], Error>) -> Void) {
        let urlString = "https://api.unsplash.com/photos/random?client_id=\(clientID)&count=30"
        
        guard let url = URL(string: urlString) else {
            let urlError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let responseError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response from server"])
                completion(.failure(responseError))
                return
            }
            
            guard httpResponse.statusCode == 200 else {
                let statusCodeError = NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Invalid response code: \(httpResponse.statusCode)"])
                completion(.failure(statusCodeError))
                return
            }
            
            guard let data = data else {
                let noDataError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received from server"])
                completion(.failure(noDataError))
                return
            }
            
            do {
                let decodedPhotos = try JSONDecoder().decode([Photo].self, from: data)
                completion(.success(decodedPhotos))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func searchPhotos(query: String, completion: @escaping (Result<PhotoResponse, Error>) -> Void) {
            let urlString = "https://api.unsplash.com/search/photos/?client_id=\(clientID)&per_page=30&query=\(query)"
        print(urlString)
            guard let url = URL(string: urlString) else {
                let urlError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
                completion(.failure(urlError))
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    let responseError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response from server"])
                    completion(.failure(responseError))
                    return
                }
                guard let data = data else {
                    let noDataError = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received from server"])
                    completion(.failure(noDataError))
                    return
                }
                do {
                    let decodedPhotos = try JSONDecoder().decode(PhotoResponse.self, from: data)
                    completion(.success(decodedPhotos))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }

}
