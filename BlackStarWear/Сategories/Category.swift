//
//  Category.swift
//  BlackStarWear
//
//  Created by Владислав Климов on 14.02.2020.
//  Copyright © 2020 Владислав Климов. All rights reserved.
//

import Foundation
import UIKit

struct Category {
    let id: String
    let name: String
    let imageLink: String
    let sortOrder: String
    let subcategories: [Category]?
    var image: UIImage?
}
