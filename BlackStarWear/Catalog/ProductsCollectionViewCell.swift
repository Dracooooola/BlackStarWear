//
//  ProductsCollectionViewCell.swift
//  BlackStarWear
//
//  Created by Владислав Климов on 18.02.2020.
//  Copyright © 2020 Владислав Климов. All rights reserved.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    @IBAction func goToProduct(_ sender: UIButton) {
    }
    
}
