//
//  ResponseModels.swift
//  OrderApp
//
//  Created by 杉原大貴 on 2021/01/22.
//

import Foundation

struct MenuResponse: Codable {
    let items: [MenuItem]
}

struct CategoriesResponse: Codable {
    let categories: [String]
}
