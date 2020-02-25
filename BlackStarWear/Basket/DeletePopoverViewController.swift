//
//  DeletePopoverViewController.swift
//  BlackStarWear
//
//  Created by Владислав Климов on 25.02.2020.
//  Copyright © 2020 Владислав Климов. All rights reserved.
//

import UIKit

class DeletePopoverViewController: UIViewController {

    @IBOutlet weak var popoverView: UIView!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    @IBAction func deleteAction(_ sender: UIButton) {
        if let delegate = delegate, let indexPath = indexPath {
            delegate.deleteItem(indexPath: indexPath)
            removeAnimate()
        }
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        removeAnimate()
    }
    
    var indexPath: IndexPath?
    var delegate: DeletePopoverViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yesButton.layer.cornerRadius = 10
        noButton.layer.cornerRadius = 10
        noButton.layer.borderColor = CGColor.init(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        noButton.layer.borderWidth = 1
        popoverView.layer.cornerRadius = 10
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.showAnimate()
    }
    
    private func showAnimate(){
        self.view.transform = .init(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = .init(scaleX: 1.0, y: 1.0)
        })
    }
    
    private func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = .init(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: {
            finished in
            if finished {
                self.view.removeFromSuperview()
            }
        })
    }
}

protocol DeletePopoverViewControllerDelegate: AnyObject {
    func deleteItem(indexPath: IndexPath)
}
