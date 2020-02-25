//
//  Persistance.swift
//  BlackStarWear
//
//  Created by Владислав Климов on 25.02.2020.
//  Copyright © 2020 Владислав Климов. All rights reserved.
//

import Foundation
import RealmSwift


class Persistance {
    static let shared = Persistance()
    
    private let realm = try! Realm()
}
