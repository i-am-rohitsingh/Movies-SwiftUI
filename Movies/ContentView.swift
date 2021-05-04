//
//  ContentView.swift
//  Movies
//
//  Created by Rohit Kumar on 03/05/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            Group{
                MoviesView()
            }.navigationBarTitle("Movies", displayMode: .automatic)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
