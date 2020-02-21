//
//  Product.swift
//  BlackStarWear
//
//  Created by Владислав Климов on 18.02.2020.
//  Copyright © 2020 Владислав Климов. All rights reserved.
//

import Foundation
import UIKit

struct Product {
    
    let id: String
    let name: String
    let sortOrder: String
    let article: String
    let collection: String?
    var description: String
    let colorName: String
    let mainImageLink: String
    let arrayImageLinks: [String]?
    
    let price: String
    
    var mainImage: UIImage? = nil
    var gallery: [UIImage?] = []
    
    let productAttributes: [[String : String]]
}
