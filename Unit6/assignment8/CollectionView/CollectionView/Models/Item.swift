//
//  Item.swift
//  CollectionView
//
//  Created by 杉原大貴 on 2021/02/08.
//

import Foundation

enum Item: Hashable {
    case movie(Movie)
    case category(Genre)
    
    var movie: Movie? {
        if case .movie(let movie) = self {
            return movie
        } else {
            return nil
        }
    }
    
    var genre: Genre? {
        if case .category(let category) = self {
            return category
        } else {
            return nil
        }
    }
    
    static var movies = [Item]()
    static var categories: [Item] = [
        .category(Genre(genreId: 28, name: "Action")),
        .category(Genre(genreId: 12, name: "Adventure")),
        .category(Genre(genreId: 16, name: "Animation")),
        .category(Genre(genreId: 35, name: "Comedy")),
        .category(Genre(genreId: 80, name: "Crime")),
        .category(Genre(genreId: 99, name: "Documentary")),
        .category(Genre(genreId: 18, name: "Drama")),
        .category(Genre(genreId: 10751, name: "Family")),
        .category(Genre(genreId: 14, name: "Fantasy")),
        .category(Genre(genreId: 36, name: "History")),
        .category(Genre(genreId: 27, name: "Horror")),
        .category(Genre(genreId: 10402, name: "Music")),
        .category(Genre(genreId: 9648, name: "Mystery")),
        .category(Genre(genreId: 10749, name: "Romance")),
        .category(Genre(genreId: 878, name: "Science Fiction")),
        .category(Genre(genreId: 53, name: "Thriller")),
        .category(Genre(genreId: 10770, name: "TV Movie")),
        .category(Genre(genreId: 10752, name: "War")),
        .category(Genre(genreId: 37, name: "Western")),
    ]    
}
