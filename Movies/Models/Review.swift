//
//  Review.swift
//  Movies
//
//  Created by Rohit Kumar on 03/05/21.
//

import Foundation

struct ReviewResponse: Codable {
    var results: [Review]
}

struct Review: Codable, Identifiable {
    var id: String?
    var author: String?
    var content: String?
}
