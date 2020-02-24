//
//  SingleProductViewController.swift
//  BlackStarWear
//
//  Created by Владислав Климов on 19.02.2020.
//  Copyright © 2020 Владислав Климов. All rights reserved.
//

import UIKit

class SingleProductViewController: UIViewController {

    @IBOutlet weak var UIViewScroll: UIView!
        
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    @IBOutlet weak var buyButton: UIButton!
    @IBAction func buyAction(_ sender: UIButton) {
    }
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var attributesStackView: UIStackView!
    @IBOutlet weak var attributesStackViewLine: UIStackView!
    @IBOutlet weak var attributeName: UILabel!
    @IBOutlet weak var attributeData: UILabel!
        
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addImage()
        self.refactorDescription()


        buyButton.layer.cornerRadius = 10
        
        guard let product = self.product else {return}
        pageControl.numberOfPages = 1 + (product.arrayImageLinks?.count ?? 0)
        descriptionLabel.text = product.description
        nameLabel.text = product.name
        priceLabel.text = product.price + "₽"
    }
    
    private func addImage(){
        guard let product = self.product, let arrayLinks = product.arrayImageLinks else { return }
        for value in arrayLinks {
            Loader().loadImage(link: value) {
                gotImage in
                self.product?.gallery.append(gotImage)
            }
        }
    }
    
    private func refactorDescription() {
        guard let string = self.product?.description else {return}
        self.product?.description = string.replacingOccurrences(of: "&nbsp;", with: " ")
    }
    
    private func addAttributes(product: Product) {
        var attributes = product.productAttributes
            
        guard attributes.count != 0 else {
            attributeName.text = ""
            attributeData.text = ""
            return
        }
        
        let firstData = attributes.removeFirst()
        attributeName.text = firstData.first!.key + ":"
        attributeData.text = firstData.first?.value
       
        for dictinory in attributes {
            for (key, value) in dictinory {
                let newStack = UIStackView()
                newStack.frame = attributesStackViewLine.frame

                let newAttributeName = UILabel()
                newAttributeName.frame = attributeName.frame
                newAttributeName.font = attributeName.font
                newAttributeName.text = key + ":"

                let newAttributeData = UILabel()
                newAttributeData.frame = attributeData.frame
                newAttributeData.font = attributeData.font
                newAttributeData.textColor = UIColor.lightGray
                newAttributeData.text = value
               
                newStack.addArrangedSubview(newAttributeName)
                newStack.addArrangedSubview(newAttributeData)
                newStack.distribution = .equalSpacing
                attributesStackView.addArrangedSubview(newStack)
           }
       }
    }
}

extension SingleProductViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let array = self.product?.arrayImageLinks else { return 0 }
        return array.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as! SliderCollectionViewCell
        
        guard let product = self.product else { return cell }

        if indexPath.row == 0 {
            cell.sliderImage.image = product.mainImage
        } else {
            cell.sliderImage.image = product.gallery[indexPath.row - 1]
        }        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width
        let height = collectionView.frame.height
        
        return CGSize(width: width, height: height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let scrollPos = scrollView.contentOffset.x / view.frame.width
        pageControl.currentPage = Int(scrollPos)
    }
    
}
