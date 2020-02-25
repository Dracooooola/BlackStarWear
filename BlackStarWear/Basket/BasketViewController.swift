//
//  BasketViewController.swift
//  BlackStarWear
//
//  Created by Владислав Климов on 25.02.2020.
//  Copyright © 2020 Владислав Климов. All rights reserved.
//

import UIKit

class BasketViewController: UIViewController {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func goNextScreen(_ sender: UIButton) {
    }
    
    var products = Persistance.shared.getItems()
    var images: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addImage()
    }
    
    func addImage(){
        for index in self.products.indices {
            Loader().loadImage(link: self.products[index].mainImageLink) {
                gotImage in
                if let image = gotImage {
                    self.images.append(image)
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketCell", for: indexPath) as! BasketTableViewCell
        cell.nameLabel.text = products[indexPath.row].name
        cell.sizeLabel.text = products[indexPath.row].size
        cell.colorLabel.text = products[indexPath.row].colorName
        cell.priceLabel.text = products[indexPath.row].price + " ₽"
        if indexPath.row < images.count {
            cell.productImage.image = images[indexPath.row]
        }

        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
    
}

extension BasketViewController: BasketTableViewCellDelegate {
    func basketTableViewCell(_ bascketTableViewCell: BasketTableViewCell, indexPath: IndexPath) {
        let popover = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DeletePopover") as! DeletePopoverViewController
        self.addChild(popover)
        popover.view.frame = self.view.frame
        popover.indexPath = indexPath
        popover.delegate = self
        self.view.addSubview(popover.view)
        popover.didMove(toParent: self)
    }
}

extension BasketViewController: DeletePopoverViewControllerDelegate {
    func deleteItem(indexPath: IndexPath) {
        Persistance.shared.remove(index: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
}
