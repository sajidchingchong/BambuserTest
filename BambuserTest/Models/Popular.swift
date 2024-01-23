//
//  Popular.swift
//  BambuserTest
//
//  Created by test on 21/01/2024.
//

import UIKit

struct Popular: Codable {
    
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
}
