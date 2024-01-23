//
//  MockMovieService.swift
//  BambuserTestTests
//
//  Created by test on 22/01/2024.
//

import UIKit

class MockMovieService: MovieAPIService {
    
    func getPopularMovies(page: Int, completion: @escaping (Error?, Popular?) -> Void) {
        switch page {
            case 1:
                completion(nil, self.getFirstPopular())
            case 2:
                completion(nil, self.getSecondPopular())
            case 3:
                completion(nil, self.getThirdPopular())
            case 4:
                completion(NSError(domain: "Unexpected Error", code: -1), nil)
            default:
                print("Will not happen")
        }
    }
    
    func getPosterIconFullPath(identifier: String) -> String {
        return "Icon Full Path"
    }
    
    func getPosterOriginalFullPath(identifier: String) -> String {
        return "Original Full Path"
    }
    
    func getFirstPopular() -> Popular {
        return Popular(page: 1, results: [Movie(overview: "Some Overview", popularity: 1, posterPath: "Some Path", releaseDate: Date(), title: "1", voteAverage: 1)], totalPages: 3, totalResults: 3)
    }
    
    func getSecondPopular() -> Popular {
        return Popular(page: 2, results: [Movie(overview: "Some Overview", popularity: 2, posterPath: "Some Path", releaseDate: Date(), title: "2", voteAverage: 2)], totalPages: 3, totalResults: 3)
    }
    
    func getThirdPopular() -> Popular {
        return Popular(page: 3, results: [Movie(overview: "Some Overview", popularity: 3, posterPath: "Some Path", releaseDate: Date(), title: "3", voteAverage: 3)], totalPages: 3, totalResults: 3)
    }
    
}
