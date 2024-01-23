//
//  MovieAPIService.swift
//  BambuserTest
//
//  Created by test on 21/01/2024.
//

import UIKit

protocol MovieAPIService {
    
    func getPopularMovies(page: Int, completion: @escaping (Error?, Popular?) -> Void)
    
    func getPosterIconFullPath(identifier: String) -> String
    
    func getPosterOriginalFullPath(identifier: String) -> String
    
}
