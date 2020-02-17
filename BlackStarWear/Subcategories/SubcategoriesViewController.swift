//
//  SubcategoriesViewController.swift
//  BlackStarWear
//
//  Created by Владислав Климов on 17.02.2020.
//  Copyright © 2020 Владислав Климов. All rights reserved.
//

import UIKit

class SubcategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var subcategories: [Category] = []
    var screenName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = self.screenName
    }
    
    func addImage(){
        for index in self.subcategories.indices {
            CotegoriesLoader().loadImage(link: self.subcategories[index].imageLink){
                gotImage in
                self.subcategories[index].image = gotImage
                self.tableView.reloadData()
            }
        }
    }
    
}

extension SubcategoriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subcategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell") as! CategoriesTableViewCell
        cell.categoryName.text = subcategories[indexPath.row].name
        
        if let image = subcategories[indexPath.row].image {
            cell.categoryImage.image = image
            cell.categoryImage.contentMode = UIView.ContentMode.scaleAspectFill
        } else {
            cell.categoryImage.image = nil
        }

        return cell
    }
}
