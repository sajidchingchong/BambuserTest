//
//  Movie.swift
//  BambuserTest
//
//  Created by test on 21/01/2024.
//

import UIKit

struct Movie: Codable {
    
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: Date
    let title: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
        case voteAverage = "vote_average"
    }
    
}
