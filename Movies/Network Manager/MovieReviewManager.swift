//
//  MovieReviewManager.swift
//  Movies
//
//  Created by Rohit Kumar on 03/05/21.
//

import SwiftUI

final class MovieReviewManager: ObservableObject{
    @Published var reviews = [Review]()
    
    private var movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    func getMovieReview(){
        let url = "\(API.BaseURL)\(movie.id ?? 100)/reviews?api_key=\(API.Key)"
        NetworkManager<ReviewResponse>.fetch(from: url) { (result) in
            switch result{
            case .success(let response):
                self.reviews = response.results
            case .failure(let err):
                print(err)
            }
            
        }
    }
}
