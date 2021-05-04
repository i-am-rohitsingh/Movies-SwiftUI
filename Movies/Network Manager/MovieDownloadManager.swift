//
//  MovieDownloadManager.swift
//  Movies
//
//  Created by Rohit Kumar on 03/05/21.
//

import SwiftUI

final class MovieDownloadManager: ObservableObject{
    @Published var movies = [Movie]()
    @Published var cast = [Cast]()
    @Published var crew = [Crew]()
    @Published var similarMovies = [Movie]()
    @Published var endOfSimilarList = false
    @Published var endOfMoviesList = false

    private var moviesCurrentPage = 0
    private var similarMoviesCurrentPage = 0

    
    func applyUserFilter(_ input: String) -> [Movie]{
        if input.count == 0{
            return movies
        }
        else if input.count == 1{
            return self.movies.filter{
                let sepTitle = $0.title?.lowercased().components(separatedBy: " ")
                var isfiltered = false
                sepTitle?.forEach{ word in
                    if word[0] == input{
                        isfiltered = true
                    }
                }
                return isfiltered
            }
        }else {
            return self.movies.filter{
                guard let title = $0.title else {return false}
                let setSep = Set(title.lowercased().components(separatedBy: " "))
                let findListSet = Set(input.components(separatedBy: " "))
                return findListSet.isSubset(of: setSep)
            }
        }
    }
    
    func shouldLoadMore(movie : Movie) -> Bool{
        if let lastId = movies[movies.count - 5].id{
            if movie.id == lastId{
                return true
            }
            else{
                return false
            }
        }
        return false
    }
    
    func shouldLoadMore(similarMovie : Movie) -> Bool{
        if let lastId = similarMovies.last?.id{
            if similarMovie.id == lastId{
                return true
            }
            else{
                return false
            }
        }
        return false
    }
    
    func getMovies(){
        let url = "\(API.BaseURL)now_playing?api_key=\(API.Key)&language=en-US&page=\(self.moviesCurrentPage+1)"
        NetworkManager<MovieResponse>.fetch(from: url){ (result) in
            print(self.moviesCurrentPage)
            switch result{
            case .success(let movieResponse):
                self.moviesCurrentPage = movieResponse.page
                self.movies.append(contentsOf: movieResponse.results)
                if movieResponse.page == movieResponse.total_pages{
                    self.endOfMoviesList = true
                }
            case .failure(let err):
                print(err)
//                self.endOfMoviesList = true
            }
        }
    }
    
    func getCast(for movie: Movie){
        let url = "\(API.BaseURL)\(movie.id ?? 100)/credits?api_key=\(API.Key)&language=en-US&page=1"
        NetworkManager<CastResponse>.fetch(from: url){ (result) in
            switch result{
            case .success(let castResponse):
                self.cast = castResponse.cast
                self.crew = castResponse.crew
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getSimilarMovies(movie_id: Int){
        let url = "\(API.BaseURL)\(movie_id)/similar?api_key=\(API.Key)&language=en-US&page=\(self.similarMoviesCurrentPage)"
        NetworkManager<SimilarMovieResponse>.fetch(from: url){ (result) in
            switch result{
            case .success(let similarMovieResponse):
                self.similarMoviesCurrentPage = similarMovieResponse.page + 1
                self.similarMovies.append(contentsOf: similarMovieResponse.results)
                if similarMovieResponse.page == similarMovieResponse.total_pages{
                    self.endOfSimilarList = true
                }
            case .failure(let err):
                print(err)
                self.endOfSimilarList = true
            }
        }
    }
}

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}
