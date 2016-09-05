//
//  CartViewController.swift
//  CuelogicMachineTest
//
//  Created by Ninad Panchbhai on 9/4/16.
//  Copyright © 2016 Ninad Panchbhai. All rights reserved.
//

import UIKit

class CartViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource, CartHandlerDelegate {
    
    
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var displayTotalView: UIView!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    var cartItemsArr : NSMutableArray = NSMutableArray()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        cartItemsArr.removeAllObjects()
        super.viewWillAppear(animated)
        for items in shopingItemsarr
        {
            if (items.isAddedToCart == true)
            {
                cartItemsArr.addObject(items)
            }
        }
        
        if cartItemsArr.count == 0
        {
            cartTableView.hidden = true
            displayTotalView.hidden = true
        }
        else
        {
            cartTableView.hidden = false
            displayTotalView.hidden = false
            calculateAndDisplayTotal()
            cartTableView.reloadData()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItemsArr.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 160
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cartTableCell = tableView.dequeueReusableCellWithIdentifier("cartCell", forIndexPath: indexPath) as? cartTableViewCell
        
        if cartTableCell == nil {
            tableView.registerClass(cartTableViewCell.self, forCellReuseIdentifier: "cartCell")
            cartTableCell = tableView.dequeueReusableCellWithIdentifier("cartCell") as? cartTableViewCell
            
        }
        let productItem = cartItemsArr[indexPath.row] as! ShoperDataModel
        cartTableCell?.productNameLabel.text = productItem.productname
        cartTableCell?.priceLabel.text = productItem.price
        cartTableCell?.vendorAddressLabel.text = productItem.vendoraddress
        cartTableCell?.vendorNameLabel.text = productItem.vendorname
        let URL = NSURL(string: shopingItemsarr[indexPath.row].productImg)!
        cartTableCell?.productImageView.af_setImageWithURL(URL)
        cartTableCell?.layer.borderColor = UIColor.blackColor().CGColor
        cartTableCell?.layer.borderWidth = 1.0
        cartTableCell?.callVendor.tag = indexPath.row
        cartTableCell?.removeFromCart.tag = indexPath.row
        cartTableCell?.cartDelegate = self
        
        
        cartTableCell?.removeFromCart.backgroundColor = UIColor.clearColor()
        cartTableCell?.removeFromCart.layer.cornerRadius = 5
        cartTableCell?.removeFromCart.layer.borderWidth = 1
        cartTableCell?.removeFromCart.layer.borderColor = UIColor.blackColor().CGColor
        
        cartTableCell?.callVendor.backgroundColor = UIColor.clearColor()
        cartTableCell?.callVendor.layer.cornerRadius = 5
        cartTableCell?.callVendor.layer.borderWidth = 1
        cartTableCell?.callVendor.layer.borderColor = UIColor.blackColor().CGColor
        return cartTableCell!
    }
    func calculateAndDisplayTotal()
    {
        var total : Int = 0
        for product in cartItemsArr
        {
            total = total + Int(product.price)!
        }
        self.totalLabel.text = "Total is - \(total)"
    }
    
    func removeFromCart(cellNumber: Int) {
        
        
        for item in shopingItemsarr
        {
            if (item.productname == cartItemsArr.objectAtIndex(cellNumber).productname)
            {
                item.isAddedToCart = false
            }
        }
        cartItemsArr.removeObjectAtIndex(cellNumber)
        calculateAndDisplayTotal()
        cartTableView.reloadData()
    }
    func callVendor(cellNumber: Int) {
        
        let formatedNumber = cartItemsArr[cellNumber].phoneNumber!!.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet).joinWithSeparator("")
        let phoneUrl = "tel://\(formatedNumber)"
        let url:NSURL = NSURL(string: phoneUrl)!
        UIApplication.sharedApplication().openURL(url)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
