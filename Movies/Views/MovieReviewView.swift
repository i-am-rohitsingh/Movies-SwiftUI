//
//  MovieReviewView.swift
//  Movies
//
//  Created by Rohit Kumar on 03/05/21.
//

import SwiftUI

struct MovieReviewView: View {
    var movie: Movie
    
    @ObservedObject var movieReviewManager: MovieReviewManager
    
    init(movie: Movie) {
        self.movie = movie
        self.movieReviewManager = MovieReviewManager(movie: movie)
        
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableViewCell.appearance().selectionStyle = .none
        UITableViewCell.appearance().backgroundColor = .clear
        
        UINavigationBar.appearance().backgroundColor = .clear
    }
    
    var body: some View{
        ZStack(alignment: .top){
            Color.black.opacity(0.7)
            
            List{
                ForEach(movieReviewManager.reviews) { review in
                    VStack{
                        Text(review.author ?? "-")
                            .font(.title)
                            .bold()
                        
                        Text(review.content ?? "-")
                            .font(.body)
                            .lineLimit(nil)
                    }
                    .foregroundColor(.white)
                    .listRowBackground(Color.clear)
                }
            }
            .onAppear(){
                movieReviewManager.getMovieReview()
            }
            .padding(.horizontal, 32)
        }.edgesIgnoringSafeArea(.all)
    }
}
