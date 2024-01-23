//
//  MoviePresenter.swift
//  BambuserTest
//
//  Created by test on 21/01/2024.
//

import UIKit

protocol MoviePresenterDelegate: AnyObject {
    func didGetPopularMovies(message: String?)
    func didFilterMovies(text: String)
}

class MoviePresenter: NSObject {

    let apiService: MovieAPIService
    
    var page: Int = 0
    
    var movies: [Movie] = []
    
    var filteredMovies: [Movie] = []
    
    weak var delegate: MoviePresenterDelegate?
    
    init(apiService: MovieAPIService = MovieService()) {
        self.apiService = apiService
    }
    
    func getPopularMovies(refresh: Bool = false) {
        let nextPage: Int = refresh ? 1 : self.page + 1
        
        self.apiService.getPopularMovies(page: nextPage) { (error: Error?, popular: Popular?) in
            // TODO: Improve the error handling
            if let error = error as? NSError {
                if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                    if let data = UserDefaults.standard.object(forKey: String(nextPage)) as? Data {
                        if let popular = try? JSONDecoder().decode(Popular.self, from: data) {
                            self.handlePagination(refresh: refresh, movies: popular.results)
                            self.delegate?.didGetPopularMovies(message: nil)
                        } else {
                            self.delegate?.didGetPopularMovies(message: error.localizedDescription)
                        }
                    } else {
                        self.delegate?.didGetPopularMovies(message: error.localizedDescription)
                    }
                } else if error.domain == ConstantsAndUtilityFunctions.HTTP_ERROR {
                    self.delegate?.didGetPopularMovies(message: HTTPURLResponse.localizedString(forStatusCode: error.code))
                } else {
                    self.delegate?.didGetPopularMovies(message: error.localizedDescription)
                }
            } else {
                do {
                    UserDefaults.standard.set(try JSONEncoder().encode(popular), forKey: String(nextPage))
                } catch {
                    print(error.localizedDescription)
                }
                self.handlePagination(refresh: refresh, movies: popular!.results)
                self.delegate?.didGetPopularMovies(message: nil)
            }
        }
    }
    
    func filterMovies(text: String) {
        if text.isEmpty {
            self.filteredMovies = movies
        } else {
            self.filteredMovies = self.movies.filter({ movie in
                movie.title.lowercased().contains(text)
            })
        }
        self.delegate?.didFilterMovies(text: text)
    }
    
    func getPosterIconFullPath(identifier: String) -> String {
        return self.apiService.getPosterIconFullPath(identifier: identifier)
    }
    
    func getPosterOriginalFullPath(identifier: String) -> String {
        return self.apiService.getPosterOriginalFullPath(identifier: identifier)
    }
    
    func handlePagination(refresh: Bool, movies: [Movie]) {
        if refresh {
            self.page = 1
            self.movies = movies
        } else {
            self.page += 1
            self.movies.append(contentsOf: movies)
        }
        self.filteredMovies = self.movies
    }
    
}
