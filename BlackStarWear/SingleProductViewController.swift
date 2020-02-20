//
//  SingleProductViewController.swift
//  BlackStarWear
//
//  Created by Владислав Климов on 19.02.2020.
//  Copyright © 2020 Владислав Климов. All rights reserved.
//

import UIKit

class SingleProductViewController: UIViewController {

    @IBOutlet weak var UIViewScroll: UIView!
    
    @IBOutlet weak var slider: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var compositionLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var careLabel: UILabel!
    
    @IBOutlet weak var buyButton: UIButton!
    @IBAction func buyAction(_ sender: UIButton) {
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refactorDescription()
        
        slider.image = self.product?.mainImage
        descriptionLabel.text = product?.description
        nameLabel.text = product?.name
    }
    
    private func addImage(){
        guard let product = self.product, let arrayLinks = product.arrayImageLinks else { return }
        for value in arrayLinks {
            Loader().loadImage(link: value) {
                gotImage in
                self.product?.gallery.append(gotImage)
            }
        }
    }
    
    private func refactorDescription() {
        guard let string = self.product?.description else {return}
        self.product?.description = string.replacingOccurrences(of: "&nbsp;", with: " ")
    }
}
