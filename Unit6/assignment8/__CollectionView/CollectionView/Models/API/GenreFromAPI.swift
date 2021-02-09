//
//  Genre.swift
//  CollectionView
//
//  Created by 杉原大貴 on 2021/02/07.
//

import Foundation

struct GenreFromAPI: Codable {
    let genres: [Genres]
    
    struct Genres: Codable {
        let id: Int
        let name: String
    }
}
