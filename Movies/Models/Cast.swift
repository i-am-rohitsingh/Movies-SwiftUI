//
//  Casts.swift
//  Movies
//
//  Created by Rohit Kumar on 03/05/21.
//

import Foundation

struct CastResponse: Codable {
    var cast: [Cast]
    var crew: [Crew]
}

struct Cast: Codable, Identifiable {
    var id: Int?
    var name: String?
    var character: String?
    var profile_path: String?
    var profilePhoto: String {
        if let path = profile_path{
            return "https://image.tmdb.org/t/p/original/\(path)"
        }else{
            return ""
        }
    }
}

struct Crew: Codable, Identifiable {
    var id: Int?
    var name: String?
    var job: String?
    var profile_path: String?
    var profilePhoto: String {
        if let path = profile_path{
            return "https://image.tmdb.org/t/p/original/\(path)"
        }else{
            return ""
        }
    }
}
