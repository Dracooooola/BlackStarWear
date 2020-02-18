//
//  CatalogCollectionViewController.swift
//  BlackStarWear
//
//  Created by Владислав Климов on 18.02.2020.
//  Copyright © 2020 Владислав Климов. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CatalogCell"

class CatalogCollectionViewController: UICollectionViewController {

    var categoryId = ""
    var products: [Product] = []
    var screenName = ""
    var backBtnName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = self.screenName
        navigationItem.backBarButtonItem?.title = self.backBtnName
        Loader().loadCatalog(categoryId: categoryId, completition: {
            products in
            self.products = products
            self.collectionView.reloadData()
            self.addImage()
        })
    }
    
    func addImage(){
        for index in self.products.indices {
            Loader().loadImage(link: self.products[index].mainImageLink) {
                gotImage in
                self.products[index].mainImage = gotImage
                self.collectionView.reloadData()
            }
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProductsCollectionViewCell
        cell.nameLabel.text = products[indexPath.row].name
        cell.priceLabel.text = products[indexPath.row].price + " ₽"
//        cell.button.layer.cornerRadius = 5
//        cell.button.backgroundColor = UIColor(red: 0.967, green: 0.234, blue: 0.41, alpha: 0.85)
        cell.button.isHidden = true
        
        if let image = products[indexPath.row].mainImage {
            let width = cell.mainImage.frame.width
            let ratio = width / image.size.width
            let newSize = CGSize(width: width, height: image.size.height * ratio)

            UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
            image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()

            cell.mainImage.image = newImage
        } else {
            cell.mainImage.image = nil
        }

        return cell
    }
    
    
    
    
    
    
    
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
