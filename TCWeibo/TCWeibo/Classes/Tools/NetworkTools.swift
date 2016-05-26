//
//  NetworkTools.swift
//  TCWeibo
//
//  Created by TailC on 16/5/26.
//  Copyright © 2016年 TailC. All rights reserved.
//

import UIKit
import AFNetworking

class NetworkTools: AFHTTPSessionManager {
	
	static var instance: NetworkTools?
	static var token: dispatch_once_t = 0
	class func shareNetworkTools() -> NetworkTools {
		dispatch_once(&token) { () -> Void in
			self.instance = NetworkTools()
			
			let baseURL = NSURL(string: "https://api.weibo.com/")
			let tools = NetworkTools(baseURL:baseURL)
			
			// 设置反序列化数据格式集合
			tools.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as? Set<String>
			
		}
		return instance!
	}
	
}
