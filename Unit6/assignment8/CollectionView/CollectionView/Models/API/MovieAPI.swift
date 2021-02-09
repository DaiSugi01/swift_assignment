//
//  MovieAPI.swift
//  CollectionView
//
//  Created by 杉原大貴 on 2021/02/08.
//

import Foundation

class MovieAPI {
    static let shared = MovieAPI()
    private var dataTask: URLSessionDataTask?
    private init() {}
    
    func fetcheMovie(completion: @escaping (Result<MovieFromDatabaseAPI, NetworkError>) -> Void) {
        var urlComponents = URLComponents(string: Endpoint.discoverMovieUrl)!
        urlComponents.queryItems = [
            Parameter.apikey: MovieAPIKey.apiKey,
            Parameter.language: "en-US",
            Parameter.sortBy: "popularity.desc",
            Parameter.includeAdult: "false",
            Parameter.includeVideo: "true",
            Parameter.page: "500"
        ].map { URLQueryItem(name: $0.key, value: $0.value) }
        
        fetch(from: urlComponents.url!) { (result: Result<MovieFromDatabaseAPI, NetworkError>) in
            completion(result)
        }
    }
    
    func fetcheGenre(completion: @escaping (Result<GenreFromAPI, NetworkError>) -> Void) {
        var urlComponents = URLComponents(string: Endpoint.genreUrl)!
        urlComponents.queryItems = [
            Parameter.apikey: MovieAPIKey.apiKey,
            Parameter.language: "en-US"
        ].map { URLQueryItem(name: $0.key, value: $0.value) }
        
        fetch(from: urlComponents.url!) { (result: Result<GenreFromAPI, NetworkError>) in
            completion(result)
        }
    }
    
    private func fetch<T: Decodable>(from url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        dataTask = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.client(message: "invalid request")))
                return
            }
            
            guard let res = response as? HTTPURLResponse, (200...299).contains(res.statusCode) else {
                completion(.failure(.server))
                return
            }
            
            do {
                guard let data = data else {
                    completion(.failure(.client(message: "response body(data) is nil")))
                    return
                }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(.client(message: error.localizedDescription)))
            }
        }
        dataTask?.resume()
    }
}

struct Endpoint {
    static let discoverMovieUrl = "https://api.themoviedb.org/3/discover/movie"
    static let genreUrl = "https://api.themoviedb.org/3/genre/movie/list"
}

struct Parameter {
    static let apikey = "api_key"
    static let language = "language"
    static let sortBy = "sort_by"
    static let includeAdult = "include_adult"
    static let includeVideo = "include_video"
    static let page = "page"
}

enum NetworkError: Error {
    case client(message: String)
    case server
}

