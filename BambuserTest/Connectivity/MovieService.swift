//
//  MovieService.swift
//  BambuserTest
//
//  Created by test on 21/01/2024.
//

import UIKit

class MovieService: MovieAPIService {
    
    static let TMDB_API_KEY: String = "TMDB_API_KEY"
    
    static let TMDB_DATE_FORMAT: String = "yyyy-MM-dd"
    
    static let IMAGE_BASE_URL: String = "https://image.tmdb.org/t/p/"
    
    static let API_BASE_URL: URL! = URL(string: "https://api.themoviedb.org/3/movie/")
    
    let session: URLSession = URLSession(configuration: URLSessionConfiguration.default)
    
    func getPopularMovies(page: Int, completion: @escaping (Error?, Popular?) -> Void) {
        var url: URL! = URL(string: "popular?api_key=328c283cd27bd1877d9080ccb1604c91", relativeTo: Self.API_BASE_URL)
        url.append(queryItems: [URLQueryItem(name: "language", value: "en-US"), URLQueryItem(name: "page", value: String(page))])
        print("url: \(String(describing: url))")
        
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.addValue("accept", forHTTPHeaderField: "application/json")
        if let apiKey = Bundle.main.infoDictionary?[Self.TMDB_API_KEY] {
            urlRequest.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        }
        print("urlRequest: \(String(describing: urlRequest))")
        
        let dataTask: URLSessionDataTask = self.session.dataTask(with: urlRequest) { (data: Data?, urlResponse: URLResponse?, error: Error?) in
            if let error = error {
                completion(error, nil)
                return
            }
            
            if let response = urlResponse as? HTTPURLResponse {
                let statusCode = response.statusCode
                if (statusCode < 200 || response.statusCode >= 300) {
                    completion(NSError(domain: ConstantsAndUtilityFunctions.HTTP_ERROR, code: statusCode), nil)
                } else {
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .custom { decoder in
                            let container = try decoder.singleValueContainer()
                            let dateString = try container.decode(String.self)
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = Self.TMDB_DATE_FORMAT
                            if let date = dateFormatter.date(from: dateString) {
                                return date
                            } else {
                                throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateString)")
                            }
                        }
                        completion(nil, try decoder.decode(Popular.self, from: data!))
                    } catch {
                        completion(error, nil)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    func getPosterIconFullPath(identifier: String) -> String {
        return "\(Self.IMAGE_BASE_URL)w92\(identifier)"
    }
    
    func getPosterOriginalFullPath(identifier: String) -> String {
        return "\(Self.IMAGE_BASE_URL)original\(identifier)"
    }
    
}
