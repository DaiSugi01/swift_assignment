//
//  MovieFromDatabaseAPI.swift
//  CollectionView
//
//  Created by 杉原大貴 on 2021/02/08.
//

import Foundation

struct MovieFromDatabaseAPI: Codable {
    let results: [Results]
    
    struct Results: Codable {
        let id: Int
        let title: String
        let genreIds: [Int]
        let overview: String
        let posterPath: String?
        let releaseDate: String
        let video: Bool
        let voteCount: Int
        let voteAverage: Double
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case title = "title"
            case genreIds = "genre_ids"
            case overview = "overview"
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case video = "video"
            case voteCount = "vote_count"
            case voteAverage = "vote_average"
        }
    }
}
