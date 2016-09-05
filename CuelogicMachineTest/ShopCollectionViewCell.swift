//
//  ShopCollectionViewCell.swift
//  CuelogicMachineTest
//
//  Created by Ninad Panchbhai on 9/4/16.
//  Copyright © 2016 Ninad Panchbhai. All rights reserved.
//

import UIKit
import AlamofireImage

@objc protocol addToCartHandlerDelegate {
    func addToCart(cellNumber : Int)
}

class ShopCollectionViewCell: UICollectionViewCell {
    
    var addToCartDelegate:addToCartHandlerDelegate?
    
    @IBOutlet weak var productNamelabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var vendorNameLabel: UILabel!
    @IBOutlet weak var vendorAddressLabel: UILabel!
    @IBOutlet weak var addToCartBtn: UIButton!
    
    
    
    @IBAction func addToCartBtnClick(sender: UIButton)
    {
        sender.setTitle("Added To Cart", forState: .Normal)
        addToCartDelegate?.addToCart(sender.tag)
    }
}
