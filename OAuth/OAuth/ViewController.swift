//
//  ViewController.swift
//  OAuth
//
//  Created by King on 15/2/28.
//  Copyright (c) 2015年 king. All rights reserved.
//

import UIKit
// 定义全局常量
let WB_Login_Successed_Notification = "WB_Login_Successed_Notification"

class ViewController: UIViewController {

    
    let WB_API_URL_String       = "https://api.weibo.com"
    let WB_Redirect_URL_String  = "http://www.baidu.com"
    let WB_Client_ID            = "4266907357"
    let WB_Client_Secret        = "a3954639f9a74db9d7d2861f4fb94fda"
    let WB_Grant_Type           = "authorization_code"
    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        loadAuthPage()
    }
    
    func loadAuthPage() {
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=4266907357&redirect_uri=http://www.baidu.com"
        let url = NSURL(string: urlString)
        webView.loadRequest(NSURLRequest(URL: url!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UIViewController: UIWebViewDelegate {
    public func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        if let code = requestCode(request.URL!) {
            println(code)
            let urlString = "https://api.weibo.com/oauth2/access_token"
            let url = NSURL(string: urlString)
            let requestURl = NSMutableURLRequest(URL: url!)
            requestURl.HTTPMethod = "POST"
            
            var bodyStr = "client_id=4266907357&client_secret=a3954639f9a74db9d7d2861f4fb94fda&redirect_uri=http://www.baidu.com&grant_type=authorization_code&code=\(code)"
            requestURl.HTTPBody = bodyStr.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
            
            NSURLSession.sharedSession().dataTaskWithRequest(requestURl, completionHandler: { (data, _ , _ ) -> Void in
                let dict: AnyObject? = NSJSONSerialization.JSONObjectWithData(data , options: NSJSONReadingOptions.allZeros, error: nil)
                println(dict)
            }).resume()
            
        }
        return true
    }
    
    ///  截取code
    func requestCode(url: NSURL) ->String? {
        
        if let query = url.query {
            var code = "code="
            if query.hasPrefix(code) {
                return (query as NSString).substringFromIndex(code.lengthOfBytesUsingEncoding(NSUTF8StringEncoding))
            }
        }
        return nil
    }
}
