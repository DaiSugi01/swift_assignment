//
//  Order.swift
//  OrderApp
//
//  Created by 杉原大貴 on 2021/01/22.
//

import Foundation

struct Order: Codable {
    var menuItems: [MenuItem]

    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}
