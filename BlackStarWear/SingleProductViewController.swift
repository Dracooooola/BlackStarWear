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
    
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var slider: UIImageView!
    
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
    private var viewForSlider = UIView()
    private var circleSliderArray: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addImage()
        self.refactorDescription()
        
        buyButton.layer.cornerRadius = 10
        
        guard let product = self.product else {return}
        slider.image = product.mainImage
        descriptionLabel.text = product.description
        nameLabel.text = product.name
        priceLabel.text = product.price + "₽"
        
        addCircleForSlider()
        circleSliderArray[0].backgroundColor = .systemBlue
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
        
    private func addImageCircle(count i: CGFloat) -> CGFloat{
        let size: CGFloat = 10
        let spacing: CGFloat = 8
        let mutate = i * (size + spacing)
        let newCicrle = UIView(frame: CGRect(x: 0 + mutate, y: 0, width: size, height: size))
        newCicrle.backgroundColor = UIColor.white
        newCicrle.layer.cornerRadius = size / 2
        self.viewForSlider.addSubview(newCicrle)
        self.circleSliderArray.append(newCicrle)
        return mutate
    }
    
    private func addCircleForSlider() {
        guard let product = self.product else {return}
        addAttributes(product: product)
        var mutate = addImageCircle(count: 0)

        if let arrayLinks = product.arrayImageLinks{
            for i in arrayLinks.indices {
                let count = CGFloat(i) + 1
                mutate = addImageCircle(count: count)
            }
        }

        viewForSlider.frame = CGRect(x: (UIScreen.main.bounds.width - mutate - 10) / 2, y: 0, width: mutate + 10, height: 0)
        print(viewForSlider.frame.width)
        sliderView.addSubview(viewForSlider)
    }
}
