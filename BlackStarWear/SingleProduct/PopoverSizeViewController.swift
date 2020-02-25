//
//  PopoverSizeViewController.swift
//  BlackStarWear
//
//  Created by Владислав Климов on 25.02.2020.
//  Copyright © 2020 Владислав Климов. All rights reserved.
//

import UIKit

class PopoverSizeViewController: UIViewController {

    @IBOutlet weak var sizeView: UIView!
    
    var data: [[String : String]] = []
    var product = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.showAnimate()
    }

}

extension PopoverSizeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sizeCell", for: indexPath) as! SizeCellTableViewCell
        cell.sizeLabel.text = self.product + " " + (self.data[indexPath.row]["size"] ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        removeAnimate()
    }
    
    func showAnimate(){
        self.view.transform = .init(translationX: 0, y: self.view.bounds.height)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1
            self.view.transform = .init(translationX: 0, y: 0)
        })
    }
    
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = .init(translationX: 0, y: self.view.bounds.height)
            self.view.alpha = 0.0
        }, completion: {
            finished in
            if finished {
                self.view.removeFromSuperview()
            }
        })
    }
}
