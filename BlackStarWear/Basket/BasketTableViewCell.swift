//
//  BasketTableViewCell.swift
//  BlackStarWear
//
//  Created by Владислав Климов on 25.02.2020.
//  Copyright © 2020 Владислав Климов. All rights reserved.
//

import UIKit

class BasketTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBAction func deleteCell(_ sender: UIButton) {
        if let delegate = delegate, let indexPath = indexPath {
            delegate.basketTableViewCell(self, indexPath: indexPath)
        }
    }
    
    var delegate : BasketTableViewCellDelegate?
    var indexPath : IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

protocol BasketTableViewCellDelegate: AnyObject {
    func basketTableViewCell(_ bascketTableViewCell: BasketTableViewCell, indexPath: IndexPath)
}
