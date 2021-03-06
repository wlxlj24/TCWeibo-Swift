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
	
	private static let instance = NetworkTools()
	
	class var sharedInstance: NetworkTools {
		instance.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as? Set<String>
		return instance
	}
	
}
