//
//  UIBarButtonItem+Category.swift
//  TCWeibo
//
//  Created by TailC on 16/5/25.
//  Copyright © 2016年 TailC. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem{
	
	class func createBarButtonItem(imageName : String , target : AnyObject? , action:Selector) ->UIBarButtonItem {
		let btn = UIButton()
		btn.setImage(UIImage(named: imageName), forState: UIControlState.Normal)
		btn.setImage(UIImage(named: imageName + "_highlighted"), forState: UIControlState.Highlighted)
		btn.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
		btn.sizeToFit()
		return UIBarButtonItem(customView: btn)
	}
	
}