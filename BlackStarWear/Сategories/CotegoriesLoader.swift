//
//  CotegoriesLoader.swift
//  BlackStarWear
//
//  Created by Владислав Климов on 14.02.2020.
//  Copyright © 2020 Владислав Климов. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class CotegoriesLoader{
    
    private let adress = "https://blackstarshop.ru/"
    
    func loadCategories(completition: @escaping ([Category]) -> Void){
        Alamofire.request("https://blackstarshop.ru/index.php?route=api/v1/categories").responseJSON{
            response in
            if let objects = response.result.value, let jsonDict = objects as? [String : Any] {
                let categories = self.getCategories(jsonDict: jsonDict)
                DispatchQueue.main.async {
                    completition(categories)
                }
            }
        }
    }
    
    func getCategories(jsonDict: [String : Any]) -> [Category] {
        var categories: [Category] = []
        
        for (i, value) in jsonDict {
            let categoryJson = value as! [String : Any]
            let id = i
            let name = categoryJson["name"] as! String
            let sortOrder = String(describing: categoryJson["sortOrder"]!)
            let imageLink = categoryJson["image"] as! String
            
            if  let subcategories = categoryJson["subcategories"],
                let subcategoriesArray = subcategories as? [[String : Any]] {
                var subcategoriesResult: [Category] = []
                for item in subcategoriesArray{
                    let subcategoryId = String(describing: item["id"]!)
                    let subcategoryName = item["name"] as! String
                    let subcategorySortOrder = String(describing: item["sortOrder"]!)
                    let subcategoryImageLink = item["iconImage"] as! String
                    
                    let subcategory = Category(id: subcategoryId, name: subcategoryName, imageLink: subcategoryImageLink, sortOrder: subcategorySortOrder, subcategories: nil, image: nil)
                    subcategoriesResult.append(subcategory)
                }
                let category = Category(id: id, name: name, imageLink: imageLink, sortOrder: sortOrder, subcategories: subcategoriesResult, image: nil)
                categories.append(category)
            } else {
                let category = Category(id: id, name: name, imageLink: imageLink, sortOrder: sortOrder, subcategories: nil, image: nil)
                categories.append(category)
            }
        }
        
        return categories
    }
    
    func loadImage(link: String, completition: @escaping (UIImage?) -> Void) {
        var image: UIImage?
        Alamofire.request(adress + link).response{
            response in
            guard let data = response.data, let gotImage = UIImage(data: data) else { return }
            image = gotImage
            DispatchQueue.main.async {
                completition(image)
            }
        }
    }
}
