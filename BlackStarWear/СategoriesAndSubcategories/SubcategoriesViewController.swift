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
    
    private func addImage(){
        for index in self.subcategories.indices {
            Loader().loadImage(link: self.subcategories[index].imageLink){
                gotImage in
                self.subcategories[index].image = gotImage
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CatalogSegueFromSubcategories",
            let destination = segue.destination as? CatalogCollectionViewController,
            let cell = sender as? UITableViewCell,
            let i = tableView.indexPath(for: cell)
            {
                destination.categoryId = subcategories[i.row].id
                destination.screenName = subcategories[i.row].name
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "CatalogSegueFromSubcategories", sender: tableView.cellForRow(at: indexPath))
    }
}
