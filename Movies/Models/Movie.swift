//
//  Movie.swift
//  Movies
//
//  Created by Rohit Kumar on 03/05/21.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
    let total_pages: Int
    let page: Int
}

struct SimilarMovieResponse: Codable {
    let results: [Movie]
    let total_pages: Int
    let page: Int
}


struct Movie: Codable, Identifiable {
    let id: Int?
    let title: String?
    let original_language: String?
    let overview: String?
    let poster_path: String?
    let backdrop_path: String?
    let popularity: Double?
    let vote_average: Double?
    let vote_count: Int?
    let video: Bool?
    let release_date: String?
    let adult: Bool?
    var posterPath: String{
        if let path = poster_path{
            return "https://image.tmdb.org/t/p/original/\(path)"
        }else{
            return ""
        }
    }
    var voteAverage: Double{
        if let avg = vote_average{
            return avg/10.0
        }else{
            return 0.0
        }
    }
    var titleWithLang: String{
        guard let title = title, let lang = original_language else {
            return ""
        }
        return "\(title)(\(lang))"
    }
}
