//
//  NetworkManager.swift
//  Movies
//
//  Created by Rohit Kumar on 03/05/21.
//

import Foundation

final class NetworkManager<T: Codable>{
    static func fetch(from urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void){
        
        guard let url = URL(string: urlString) else {fatalError("Invalid URL")}
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.invalidResponse))
                print ("error: \(error!)")
                return
            }
            guard let data = data else {
                completion(.failure(.nilResponse))
                return
            }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch let err {
                print("Error:", err)
            }
        }
        task.resume()
    }
}

enum NetworkError: Error{
    case invalidResponse
    case nilResponse
}
