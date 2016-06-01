//
//  UserAccount.swift
//  TCWeibo
//
//  Created by TailC on 16/6/1.
//  Copyright © 2016年 TailC. All rights reserved.
//

import UIKit

class UserAccount: NSObject {

	class func loadAccessToken(params: [String: String]) {
		NetworkTools.sharedInstance.POST("https://api.weibo.com/oauth2/access_token", parameters: params, success: { (_, JSON) -> Void in
				print(JSON)
			}) { (_, error) -> Void in
				print(error)
		}
		
	}
	
}
