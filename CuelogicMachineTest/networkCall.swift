//
//  networkCall.swift
//  CuelogicMachineTest
//
//  Created by Ninad Panchbhai on 9/5/16.
//  Copyright © 2016 Ninad Panchbhai. All rights reserved.
//

import UIKit

//@objc protocol netWorkHandlerDelegate {
//    func returnsData () -> NSDictionary
//}

class networkCall: NSObject {
    
//    var networkDelegate = netWorkHandlerDelegate.self
    
    
//    func getDataFromServer  (url : String)
//    {
//        var dict : NSDictionary!
//        let url = NSURL(string: url)
//        
//        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
//            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
//            do {
//                 dict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! NSDictionary
////                networkDelegate.returnsData()
////
//                
//            } catch {
//                print(error)
//            }
//        }
//        task.resume()
////        return dict
//    }
    
    func getDataFromServer(url:String, completionHandler: (NSDictionary?, NSError?) -> ()) {
        
        var dict : NSDictionary!
        let url = NSURL(string: url)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            do {
            
                dict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! NSDictionary
                completionHandler(dict , nil)
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    
    func getDataFromNetwork(urlString: String, completion: (NSDictionary , NSError?) -> Void) {
        
        
        var dict : NSDictionary!
        let url = NSURL(string: urlString)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            do {
                
                dict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! NSDictionary
                completion(dict , nil)
                return
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    
    func dataTask(request: NSMutableURLRequest, method: String, completion: (success: Bool, object: AnyObject?) -> ()) {
        request.HTTPMethod = method
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        
        session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if let data = data {
                let json = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
                if let response = response as? NSHTTPURLResponse where 200...299 ~= response.statusCode {
                    completion(success: true, object: json)
                } else {
                    completion(success: false, object: json)
                }
            }
            }.resume()
    }
}
