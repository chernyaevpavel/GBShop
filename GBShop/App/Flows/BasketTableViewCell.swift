//
//  BasketTableViewCell.swift
//  GBShop
//
//  Created by Павел Черняев on 17.02.2022.
//

import UIKit

enum TypeBasketAction {
    case add
    case reduce
}

typealias BasketAction = (_ sender: UIButton, _ typeBasketAction: TypeBasketAction) -> ()

class BasketTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var reduceButton: UIButton!
    var basketAction: BasketAction?
    
    func configure(_ basketItem: BasketItem) {
        productName.text = basketItem.product.name
        countLabel.text = String(basketItem.count)
        let idProduct = basketItem.product.id
        addButton.tag = idProduct
        reduceButton.tag = idProduct
    }
    
    @IBAction func reduceCount(_ sender: Any) {
        if let button = sender as? UIButton {
            basketAction?(button, .reduce)
        }
        
    }
    
    @IBAction func addCount(_ sender: Any) {
        if let button = sender as? UIButton {
            basketAction?(button, .add)
        }
    }
}
