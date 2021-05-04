//
//  Utils.swift
//  Movies
//
//  Created by Rohit Kumar on 03/05/21.
//

import Foundation
class Utils {
    
//    static let utilityQueue = DispatchQueue.global(qos: .utility)
//    static let cache = NSCache<NSNumber, UIImage>()
    
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        return dateFormatter
    }()
}
