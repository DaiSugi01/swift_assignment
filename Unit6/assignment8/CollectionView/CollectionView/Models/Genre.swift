//
//  Genre.swift
//  CollectionView
//
//  Created by 杉原大貴 on 2021/02/08.
//

import Foundation

struct Genre: Hashable, Comparable {
    let genreId: Int
    let name: String
        
    static func < (lhs: Genre, rhs: Genre) -> Bool {
        return lhs.name < rhs.name
    }
}
