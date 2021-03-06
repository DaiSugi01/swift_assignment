//
//  Movie.swift
//  CollectionView
//
//  Created by 杉原大貴 on 2021/02/08.
//

import Foundation

struct Movie: Codable ,Equatable, Hashable, Comparable {
    
    static let BASE_POSTER_URL: String = "https://image.tmdb.org/t/p/w500/"

    let id: Int
    let title: String
    let overView: String
    let voteCount: Int
    let voteAverage: Double
    let releaseDate: String
    let genreIds: [Int]
    let posterImagePath: String?
    let backdropPath: String?
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return
            lhs.id == rhs.id &&
            lhs.title == rhs.title
    }
    
    static func < (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.title < rhs.title
    }
}
