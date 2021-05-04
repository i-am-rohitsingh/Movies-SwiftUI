//
//  MoviesView.swift
//  Movies
//
//  Created by Rohit Kumar on 03/05/21.
//

import SwiftUI

struct MoviesView: View {
    
    @State private var searchTerm = ""
    @State private var selectedIndex = 0
    
    @ObservedObject var movieManager = MovieDownloadManager()
    
    init(){
        UITableView.appearance().backgroundColor = UIColor.clear
        UITableViewCell.appearance().selectionStyle = .none
        UITableViewCell.appearance().backgroundColor = .clear
        
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = .orange
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.orange]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.orange]
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        movieManager.getMovies()
    }
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "magnifyingglass").imageScale(.medium)
                TextField("Search...", text: $searchTerm).textFieldStyle(RoundedBorderTextFieldStyle())
            }.padding(.horizontal)
            
            List{
                ForEach(movieManager.applyUserFilter(searchTerm.lowercased())){ movie in
                    MovieCell(movie: movie)
                        .onAppear{
                            if !movieManager.endOfMoviesList{
                                if movieManager.shouldLoadMore(movie: movie){
                                    movieManager.getMovies()
                                }
                            }
                        }.listRowBackground(Color.clear)
                    
                }
            }
            Spacer()
        }.edgesIgnoringSafeArea(.bottom)
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
