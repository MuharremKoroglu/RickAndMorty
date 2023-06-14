//
//  RMApiCall.swift
//  RickAndMorty
//
//  Created by Muharrem Köroğlu on 10.06.2023.
//

import Foundation

class RMApiCall {
    
    func executeApiCall<T : Codable> (request : RMRequest, dataType : T.Type, completion : @escaping (Result<T, ApiError>) -> Void) {
        
        URLSession.shared.dataTask(with: request.url!) { data, response, error in
            
            if error != nil {
               completion(.failure(.UrlIsNotCorrect))
            }
            
            guard let serverResponse = response as? HTTPURLResponse, serverResponse.statusCode == 200 else {
                return completion(.failure(.InvalidServiceResponse))
            }
            
            guard let data = data, error == nil else {
                return completion(.failure(.DidntFetchData))
            }
            
            do{
                let decodedData = try JSONDecoder().decode(dataType.self, from: data)
                completion(.success(decodedData))
            }catch {
                completion(.failure(.DidntParseData))
            }
 
        }.resume()
    }
    
}

enum ApiError : Error {
    case UrlIsNotCorrect
    case InvalidServiceResponse
    case DidntFetchData
    case DidntParseData
    
}
