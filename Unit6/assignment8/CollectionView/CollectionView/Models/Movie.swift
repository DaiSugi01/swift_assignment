//
//  Movie.swift
//  CollectionView
//
//  Created by 杉原大貴 on 2021/02/07.
//

import Foundation

struct Movie: Codable {
    let results: [Results]
    
    struct Results: Codable, Equatable, Hashable, Comparable {
        let id: Int
        let title: String
        let backdropPath: String?
        let genreIds: [Int]
        let originalTitle: String
        let overview: String
        let popularity: Double
        let posterPath: String?
        let releaseDate: String
        let video: Bool
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case title = "title"
            case backdropPath = "backdrop_path"
            case genreIds = "genre_ids"
            case originalTitle = "original_title"
            case overview = "overview"
            case popularity = "popularity"
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case video = "video"
        }
        
        static func == (lhs: Results, rhs: Results) -> Bool {
            return lhs.id == rhs.id
        }
        
        static func < (lhs: Results, rhs: Results) -> Bool {
            return lhs.title < rhs.title
        }
    }
}
