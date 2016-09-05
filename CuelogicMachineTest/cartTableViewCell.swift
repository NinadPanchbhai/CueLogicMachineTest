//
//  cartTableViewCell.swift
//  CuelogicMachineTest
//
//  Created by Ninad Panchbhai on 9/4/16.
//  Copyright © 2016 Ninad Panchbhai. All rights reserved.
//

import UIKit
@objc protocol CartHandlerDelegate {
    func callVendor(cellNumber : Int)
    func removeFromCart(cellNumber : Int)
}
class cartTableViewCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var vendorNameLabel: UILabel!
    @IBOutlet weak var vendorAddressLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var callVendor: UIButton!
    @IBOutlet weak var removeFromCart: UIButton!
    
    var cartDelegate:CartHandlerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func removeFromCart(sender: UIButton) {
        cartDelegate?.removeFromCart(sender.tag)
    }
    
    @IBAction func callVendor(sender: UIButton) {
        cartDelegate?.callVendor(sender.tag)
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
