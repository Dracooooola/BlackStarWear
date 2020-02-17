//
//  CategoriesViewController.swift
//  BlackStarWear
//
//  Created by Владислав Климов on 14.02.2020.
//  Copyright © 2020 Владислав Климов. All rights reserved.
//

import UIKit
import Alamofire

class CategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var categories: [Category] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CotegoriesLoader().loadCategories(completition: {
            categories in
            self.categories = categories
            self.tableView.reloadData()
            self.addImage()
        })
    }
    
    func addImage(){
        for index in self.categories.indices {
            CotegoriesLoader().loadImage(link: self.categories[index].imageLink){
                gotImage in
                self.categories[index].image = gotImage
                print("After load \(self.categories[index].name), \(self.categories[index].imageLink)")
                self.tableView.reloadData()
            }
        }
    }
    
}

extension CategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell") as! CategoriesTableViewCell
        cell.categoryName.text = categories[indexPath.row].name
        
        if let image = categories[indexPath.row].image {
            let width = cell.categoryImage.frame.width
            let ratio = width / image.size.width
            let newSize = CGSize(width: width, height: image.size.height * ratio)
            
            UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
            image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
            let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            
            cell.categoryImage.image = newImage
            cell.categoryImage.layer.cornerRadius = cell.categoryImage.frame.size.width / 2
            cell.categoryImage.contentMode = UIView.ContentMode.top
        } else {
            cell.categoryImage.image = nil
        }

        return cell
    }
    
}

