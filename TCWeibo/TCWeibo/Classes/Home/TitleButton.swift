//
//  TitleButton.swift
//  TCWeibo
//
//  Created by TailC on 16/5/25.
//  Copyright © 2016年 TailC. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

	override init(frame: CGRect) {
		
		super.init(frame:frame)
		setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
		setImage(UIImage(named:"navigationbar_arrow_down" ), forState: UIControlState.Normal)
		setImage(UIImage(named: "navigationbar_arrow_up"), forState: UIControlState.Selected)
		self.sizeToFit()
		
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		titleLabel?.frame.origin.x = 0
		imageView?.frame.origin.x = titleLabel!.frame.size.width
	}

}
