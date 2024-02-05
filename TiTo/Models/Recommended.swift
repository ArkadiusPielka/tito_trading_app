//
//  Recommended.swift
//  TiTo
//
//  Created by Arkadius Pielka on 10.01.24.
//

import Foundation


struct Recommended: Codable {
    
    var id: Int
    
    var img1: URL?
//    var img2: URL?
//    var img3: URL?
    var price: String
    var title: String
    var category: String
    var descript: String
}

//    extension Recommended {
//        var imageUrls: [URL] {
//            [img1, img2, img3].compactMap { $0 }
//        }
//    }




