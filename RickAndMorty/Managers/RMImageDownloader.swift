//
//  RMImageDownloader.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 16.07.2023.
//

import Foundation

class RMImageDownloader {
    
    static let shared = RMImageDownloader()
    
    private let downloadedImageCache = NSCache<NSString,NSData>()
    
    private init () {}
    
    func downloadImage (_ url : URL, completion : @escaping (Result<Data, Error>) -> Void) {
        
        let key = url.absoluteString as NSString
        
        //Reading from cache
        if let data = downloadedImageCache.object(forKey: key) {
            completion(.success(data as Data))
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { [ weak self ] data, response, error in
            
            guard let serverResponse = response as? HTTPURLResponse, serverResponse.statusCode == 200 else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            guard let data = data, error == nil else {
                completion(.failure(URLError(.dataNotAllowed)))
                return
            }
            
            let value = data as NSData
            //Setting image to cache
            self?.downloadedImageCache.setObject(value, forKey: key)
            
            completion(.success(data))
        }
        task.resume()
    }
}
