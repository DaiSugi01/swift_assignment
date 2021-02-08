//
//  Cuisine.swift
//  CollectionView
//
//  Created by 杉原大貴 on 2021/02/04.
//

import Foundation

struct Music: Equatable, Hashable, Comparable {
    
    let songName: String
    let artistName: String
    let genre: String
    let imageName: String
    
    static func ==(lhs: Music, rhs: Music) -> Bool {
        return
            lhs.songName == rhs.songName &&
            lhs.artistName == rhs.artistName &&
            lhs.genre == rhs.genre
    }
    
    static func < (lhs: Music, rhs: Music) -> Bool {
        return lhs.genre > rhs.genre
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(songName)
        hasher.combine(artistName)
    }
}
