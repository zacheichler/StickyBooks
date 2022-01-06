//
//  Book.swift
//  StickyBooks
//
//  Created by Zach Eichler on 2021-12-17.
//

import Foundation
import SwiftUI

struct Book: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var author: String
    var pages: Double
    var the_status: String
    var current_page: Double
    private var imageName: String
    var image: Image{
        Image(imageName)
    }
    
}
