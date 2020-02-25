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
    private var products: [Product] = []
    var screenName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = self.screenName
        Loader().loadCatalog(categoryId: categoryId, completition: {
            products in
            self.products = products
            self.collectionView.reloadData()
            self.addImage()
        })
    }
    
    private func addImage(){
        for index in self.products.indices {
            Loader().loadImage(link: self.products[index].mainImageLink) {
                gotImage in
                self.products[index].mainImage = gotImage
                self.collectionView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "ProductSegue",
            let destination = segue.destination as? SingleProductViewController,
            let cell = sender as? UICollectionViewCell,
            let i = collectionView.indexPath(for: cell)
        else { return }
        
        destination.product = products[i.row]
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ProductSegue", sender: collectionView.cellForItem(at: indexPath))
    }
}
