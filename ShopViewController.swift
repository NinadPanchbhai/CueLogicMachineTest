//
//  ShopViewController.swift
//  CuelogicMachineTest
//
//  Created by Ninad Panchbhai on 9/4/16.
//  Copyright © 2016 Ninad Panchbhai. All rights reserved.
//
import Alamofire
import AlamofireImage
import UIKit
var shopingItemsarr = [ShoperDataModel]()

class ShopViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout , addToCartHandlerDelegate {

    @IBOutlet weak var shopCollectionView: UICollectionView!
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromServer(kUrl)
        shopCollectionView.delegate = self
        shopCollectionView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopingItemsarr.count
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        return CGSizeMake(screenSize.width/2.2 , 200);
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! ShopCollectionViewCell
        cell.productNamelabel.text = shopingItemsarr[indexPath.row].productname
        cell.productPriceLabel.text = shopingItemsarr[indexPath.row].price
        cell.vendorNameLabel.text = shopingItemsarr[indexPath.row].vendorname
        cell.vendorAddressLabel.text = shopingItemsarr[indexPath.row].vendoraddress
        cell.addToCartBtn.tag = indexPath.row
        let URL = NSURL(string: shopingItemsarr[indexPath.row].productImg)!
        cell.productImageView.af_setImageWithURL(URL)
        cell.layer.borderColor = UIColor.blackColor().CGColor
        cell.layer.borderWidth = 1.0
        cell.addToCartDelegate = self
        
        if (shopingItemsarr[indexPath.row].isAddedToCart == true)
        {
            cell.addToCartBtn.setTitle("Added To Cart", forState: .Normal)
        }
        else
        {
            cell.addToCartBtn.setTitle("Add To Cart", forState: .Normal)
        }
        
        return cell
    }
    
    func getDataFromServer  (url : String)
    {
        let url = NSURL(string: url)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            do {
                let jsonDict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! NSDictionary
                print(jsonDict)
                self.parseJson(jsonDict)
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func parseJson(dict : NSDictionary)
    {
        let productsArr = dict.objectForKey(kProductKey) as! NSArray
        
        for product in productsArr {
            shopingItemsarr.append(ShoperDataModel(productname: product.objectForKey(kResponseDataKeyProductName) as! String, price: product.objectForKey(kResponseDataKeyPrice) as! String, vendorname: product.objectForKey(kResponseDataKeyVendorName)as! String, vendoraddress: product.objectForKey(kResponseDataKeyVendorAddress)as! String, productImg: product.objectForKey(kResponseDataKeyImageURL)as! String, productGallery: product.objectForKey(kResponseDataKeyProductGallery)as! NSArray, phoneNumber: product.objectForKey(kResponseDataKeyPhoneNumber)as! String, isAddedToCart: false))
        }
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.reloadViews()
        }
        
    }
    
    func reloadViews()
    {
        self.shopCollectionView.reloadData()
    }
    
    func addToCart(cellNumber: Int) {
        shopingItemsarr[cellNumber].isAddedToCart = true
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
