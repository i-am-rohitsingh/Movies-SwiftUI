//
//  MovieCell.swift
//  Movies
//
//  Created by Rohit Kumar on 03/05/21.
//

import SwiftUI

struct MovieCell: View {
    
    var movie: Movie
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .top, spacing: 20){
                    moviePoster
                VStack(alignment: .leading, spacing: 0){
                    movieTitle
                    HStack{
                        movieVotes
                        voteCount
                    }
                    movieReleaseDate
                    Spacer()
                    movieOverview
                }
            }
            Spacer()
            bookButton
        }
    }
    
    private var moviePoster: some View{
        AsyncImage(url: URL(string: movie.posterPath) ?? URL(fileURLWithPath: Bundle.main.path(forResource: "placeholder", ofType: "png")!)) {
            Rectangle().foregroundColor(Color.gray.opacity(0.4))
        } image: { (img) -> Image in
            Image(uiImage: img).resizable()
        }
        .frame(width: 100, height: 160)
        .animation(.easeInOut(duration: 0.5))
        .transition(.opacity)
        .scaledToFill()
        .cornerRadius(15)
        .shadow(radius: 15)
    }
    
    private var movieTitle: some View{
        Text(movie.titleWithLang)
            .font(.system(size: 15))
            .bold()
            .foregroundColor(.blue)
        
    }
    
    private var movieVotes: some View{
        ZStack{
            Circle()
                .trim(from: 0, to: CGFloat(movie.voteAverage))
                .stroke(Color.orange, lineWidth: 4)
                .frame(width: 50)
                .rotationEffect(.degrees(-90))
            Circle()
                .trim(from: 0, to: 1)
                .stroke(Color.orange.opacity(0.2), lineWidth: 4)
                .frame(width: 50)
                .rotationEffect(.degrees(-90))
            Text(String.init(format: "%0.2f", movie.vote_average ?? 0))
                .foregroundColor(.orange)
                .font(.subheadline)
        }.frame(height: 80)
    }
    
    private var movieReleaseDate: some View{
        Text("Release date: \(movie.release_date ?? "--")")
            .foregroundColor(.gray)
            .font(.subheadline)
    }
    
    private var voteCount: some View{
        Text("\(movie.vote_count ?? 0)")
            .font(.body)
            .foregroundColor(.gray)
    }
    
    private var movieOverview: some View{
        Text(movie.overview ?? "")
            .font(.body)
            .lineLimit(3)
            .foregroundColor(.gray)
    }
    
    private var bookButton: some View{
        NavigationLink(destination: MovieDetailView(movie: movie)) {
            Button(action: {}){
                Text("Book")
                    .frame(width: 100)
                    .foregroundColor(.red)
                    .padding(8.0)
                    .overlay(
                            RoundedRectangle(cornerRadius: 10.0)
                                .stroke(lineWidth: 2.0)
                                .foregroundColor(.red)
                        )
            }
        }
    }
}
