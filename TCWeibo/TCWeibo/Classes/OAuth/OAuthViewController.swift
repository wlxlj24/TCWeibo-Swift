//
//  OAuthViewController.swift
//  TCWeibo
//
//  Created by TailC on 16/5/30.
//  Copyright © 2016年 TailC. All rights reserved.
//

import UIKit
import SVProgressHUD

class OAuthViewController: UIViewController {

	private let WB_Client_ID = "4128241273"
	private let WB_Redirect_URL = "http://www.fangyouquan.com"
	private let WB_Client_Secret = ""
	
    override func viewDidLoad() {
        super.viewDidLoad()

		view = webView
		title = "授权微博"
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: "close")
		
		loadAuthPage()
		
    }
	
	private func loadAccessToken(code: String){
		
		let params = ["client_id": WB_Client_ID,
			"client_secret": WB_Client_Secret,
			"grant_type": "authorization_code",
			"code": code,
			"redirect_uri": WB_Redirect_URL]
		UserAccount.loadAccessToken(params)
		
	}
	
	private func loadAuthPage(){
		let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(WB_Client_ID)&redirect_uri=\(WB_Redirect_URL)"
		let url = NSURL(string: urlString)
		let request = NSURLRequest(URL: url!)
		
		webView.loadRequest(request)
	}
	
	func close(){
		SVProgressHUD.dismiss()
		dismissViewControllerAnimated(true, completion: nil)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	// MARK: - Lazy Load
	lazy var webView: UIWebView = {
		let web = UIWebView()
		web.backgroundColor = UIColor.whiteColor()
		web.delegate = self
		//FIXME: 背景内有部分黑块 
		//[webView.scrollView setContentInset:UIEdgeInsetsMake(40, 0, -40, 0)];
		
		return web
	}()

}

extension OAuthViewController: UIWebViewDelegate {
	
	func webViewDidStartLoad(webView: UIWebView) {
		SVProgressHUD.show()
	}
	
	func webViewDidFinishLoad(webView: UIWebView) {
		SVProgressHUD.dismiss()
	}
	
	func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
		// 0. 获取URL的完整字符串
		let urlStr = request.URL?.absoluteString
		// 1.如果不是回调的 URL，就继续加载
		if !urlStr!.hasPrefix(WB_Redirect_URL)
		{
			return true
		}
		// 2.如果是回调地址，需要根据 URL 中的内容，判断是否有授权码
		let query = request.URL?.query
		print(query)
		let codeStr = "code="
		if query!.hasPrefix(codeStr)
		{
			// 授权码
			let code = query!.substringFromIndex(codeStr.endIndex)
			print("授权码 " + code)
			loadAccessToken(code)
			
		}else
		{
			print("没有未授权Token")
			close()
		}
		
		return false
	}
	
}


