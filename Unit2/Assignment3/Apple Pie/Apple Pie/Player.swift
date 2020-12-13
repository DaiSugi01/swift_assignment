//
//  Player.swift
//  Apple Pie
//
//  Created by 杉原大貴 on 2020/12/12.
//

import Foundation

struct Player {
    var name: String
    var totalWins: Int = 0
    var totalLosses: Int = 0
    var point: Int = 0
    
    mutating func won() {
        totalWins += 1
    }
    
    mutating func lose() {
        totalLosses += 1
    }

    mutating func getPoint() {
        point += 1
    }
}
