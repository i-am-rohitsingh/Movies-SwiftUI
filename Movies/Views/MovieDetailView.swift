//
//  MovieDetailView.swift
//  Movies
//
//  Created by Rohit Kumar on 03/05/21.
//

import SwiftUI

struct MovieDetailView: View {
    
    @StateObject private var loader: ImageLoader
    @ObservedObject private var movieManager = MovieDownloadManager()
    
    var movie:Movie
    
    init(movie: Movie) {
        self.movie = movie
        _loader = StateObject(wrappedValue: ImageLoader(url: URL(string: movie.posterPath) ?? URL(fileURLWithPath: Bundle.main.path(forResource: "placeholder", ofType: "png")!), cache: Environment(\.imageCache).wrappedValue))
    }
    
    var body: some View {
        ZStack(alignment: .top){
            backgroundView
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .center){
                    Group{
                        headerView
                        moviePosterView
                        movieOverview
                    }
                    Divider()
                    reviewLink
                    Divider()
                    castInfo
                    Divider()
                    crewInfo
                    Divider()
                    similarMoviesView
                    Spacer()
                }.padding(.top, 84)
                .padding(.horizontal, 32)
            }
        }.edgesIgnoringSafeArea(.all)
    }
    
    private var backgroundView: some View{
        imageView.onAppear{
            loader.load()
        }
        .blur(radius: 100)
    }
    
    private var imageView: some View{
        Group{
            if loader.image != nil{
                Image(uiImage: loader.image!)
                    .resizable()
            }else{
                Rectangle().foregroundColor(.gray).opacity(0.4)
            }
        }
    }
    
    private var headerView: some View{
        VStack{
            Text(movie.titleWithLang).font(.title).multilineTextAlignment(.center)
            Text("Release Date: \(movie.release_date ?? "-")").font(.subheadline)
        }.foregroundColor(.white)
    }
    
    private var moviePosterView: some View{
        HStack(alignment: .center){
            Spacer()
            imageView.frame(width: 200, height: 320).cornerRadius(20.0)
            Spacer()
        }
    }
    
    private var movieOverview: some View{
        Text(movie.overview ?? "-")
            .font(.body)
            .foregroundColor(.white)
            .fixedSize(horizontal: false, vertical: true)
            .padding(16)
    }
    
    private var reviewLink: some View{
        VStack{
            NavigationLink(destination: MovieReviewView(movie: movie)){
                HStack{
                    Text("Reviews")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                    Spacer()
                }
            }
        }
    }
    
    private var castInfo: some View{
        VStack(alignment: .leading){
            Text("CAST").foregroundColor(.white)
            ScrollView(.horizontal, showsIndicators: true){
                HStack(alignment: .top, spacing: 20) {
                    ForEach(movieManager.cast){ cast in
                        VStack{
                            AsyncImage(url: URL(string: cast.profilePhoto) ?? URL(fileURLWithPath: Bundle.main.path(forResource: "placeholder", ofType: "png")!)){
                                Rectangle().foregroundColor(Color.gray.opacity(0.4))
                            } image : { (img) -> Image in
                                Image(uiImage: img).resizable()
                            }
                            .frame(width: 100, height: 160)
                            .animation(.easeIn(duration: 0.5))
                            .transition(.opacity)
                            .scaledToFill()
                            .cornerRadius(15)
                            .shadow(radius: 15)
                            
                            Text("\(cast.name ?? "-") as \(cast.character ?? "-")")
                                .font(.caption)
                                .foregroundColor(.white)
                                .frame(width: 100)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
            }
        }.onAppear(){
            movieManager.getCast(for: movie)
        }
    }
    
    private var crewInfo: some View{
        VStack(alignment: .leading){
            Text("CREW").foregroundColor(.white)
            ScrollView(.horizontal, showsIndicators: true){
                HStack(alignment: .top, spacing: 20) {
                    ForEach(movieManager.crew){ cast in
                        VStack{
                            AsyncImage(url: URL(string: cast.profilePhoto) ?? URL(fileURLWithPath: Bundle.main.path(forResource: "placeholder", ofType: "png")!)){
                                Rectangle().foregroundColor(Color.gray.opacity(0.4))
                            } image : { (img) -> Image in
                                Image(uiImage: img).resizable()
                            }
                            .frame(width: 100, height: 160)
                            .animation(.easeIn(duration: 0.5))
                            .transition(.opacity)
                            .scaledToFill()
                            .cornerRadius(15)
                            .shadow(radius: 15)
                            
                            Text("\(cast.name ?? "-") as \(cast.job ?? "-")")
                                .font(.caption)
                                .foregroundColor(.white)
                                .frame(width: 100)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                }
            }
        }.onAppear(){
            movieManager.getCast(for: movie)
        }
    }
    
    private var similarMoviesView: some View{
        VStack(alignment: .leading){
            Text("Similar Movies").foregroundColor(.white)
            ScrollView(.horizontal, showsIndicators: true){
                HStack(alignment: .top, spacing: 20) {
                    ForEach(movieManager.similarMovies){ similarMovie in
                        NavigationLink(destination: MovieDetailView(movie: similarMovie)) {
                            VStack{
                                AsyncImage(url: URL(string: similarMovie.posterPath) ?? URL(fileURLWithPath: Bundle.main.path(forResource: "placeholder", ofType: "png")!)){
                                    Rectangle().foregroundColor(Color.gray.opacity(0.4))
                                } image : { (img) -> Image in
                                    Image(uiImage: img).resizable()
                                }
                                .frame(width: 100, height: 160)
                                .animation(.easeIn(duration: 0.5))
                                .transition(.opacity)
                                .scaledToFill()
                                .cornerRadius(15)
                                .shadow(radius: 15)
                                
                                Text(similarMovie.titleWithLang)
                                    .font(.caption)
                                    .foregroundColor(.white)
                                    .frame(width: 100)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .onAppear{
                                if !movieManager.endOfSimilarList{
                                    if movieManager.shouldLoadMore(similarMovie: movie){
                                        movieManager.getSimilarMovies(movie_id: movie.id!)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }.onAppear(){
            if !movieManager.endOfMoviesList{
                movieManager.getSimilarMovies(movie_id: movie.id!)
            }
        }
    }
}

