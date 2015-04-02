//
//  HomeController.swift
//  OAuth
//
//  Created by King on 15/3/7.
//  Copyright (c) 2015年 king. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let urlString = "https://api.weibo.com/2/statuses/home_timeline.json?access_token=2.00X1vBNC6WVleE1f72873c14iGW_6C"
        let url = NSURL(string: urlString)
        
        NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data , _ , _ ) -> Void in
            let dict: AnyObject? = NSJSONSerialization.JSONObjectWithData(data , options: NSJSONReadingOptions.allZeros, error: nil)
            data.writeToFile("/Users/King/Desktop/status.json", atomically: true)
            println(dict)
        }).resume()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
