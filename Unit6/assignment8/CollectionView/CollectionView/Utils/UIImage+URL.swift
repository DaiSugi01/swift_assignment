//
//  UIImage++URL.swift
//  CollectionView
//
//  Created by 杉原大貴 on 2021/02/05.
//

import UIKit

extension UIImage {
    public convenience init(url: String) {

        self.init()
        guard let url = URL(string: url) else { return }
          
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)!
            return
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
    }
}
