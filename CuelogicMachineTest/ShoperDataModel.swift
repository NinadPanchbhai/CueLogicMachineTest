//
//  ShoperDataModel.swift
//  CuelogicMachineTest
//
//  Created by Ninad Panchbhai on 9/4/16.
//  Copyright © 2016 Ninad Panchbhai. All rights reserved.
//

import UIKit

class ShoperDataModel: NSObject {
    
    var productname : String!
    var price : String!
    var vendorname : String!
    var vendoraddress : String!
    var productImg : String!
    var productGallery : NSArray!
    var phoneNumber : String!
    var isAddedToCart : NSNumber!
    
    init(productname:String, price:String, vendorname:String, vendoraddress:String, productImg:String, productGallery : NSArray, phoneNumber:String,  isAddedToCart:NSNumber) {
        
         self.productname = productname
         self.price = price
         self.vendorname = vendorname
         self.vendoraddress = vendoraddress
         self.productImg = productImg
         self.productGallery = productGallery
         self.phoneNumber = phoneNumber
         self.isAddedToCart = isAddedToCart
        
    }
}
