//
//  NewFeatureCell.swift
//  TCWeibo
//
//  Created by TailC on 16/5/27.
//  Copyright © 2016年 TailC. All rights reserved.
//

import UIKit

class NewFeatureCell: UICollectionViewCell {
	
	private lazy var iconView : UIImageView = {
		return UIImageView()
	}()
	
	var imageIndex: Int = 0{
		didSet {
			iconView.image = UIImage(named: "new_feature_\(imageIndex + 1)")
		}
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		addSubview(iconView)
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		iconView.frame = bounds
		
		iconView.snp_makeConstraints { (make) -> Void in
			make.top.bottom.right.left.equalTo(self).offset(0)
		}
		
		starButton.snp_makeConstraints { (make) -> Void in
			make.bottom.equalTo(self.snp_bottom).offset(-200)
			make.centerX.equalTo(self)
		}
	}

	// MARK: - Lazy
	private lazy var starButton: UIButton = {
		
		let btn = UIButton()
		
		btn.setTitle("开始体验", forState: UIControlState.Normal)
		btn.setBackgroundImage(UIImage(named: "new_feature_finish_button"), forState: UIControlState.Normal)
		btn.setBackgroundImage(UIImage(named: "new_feature_finish_button_highlighted"), forState: UIControlState.Highlighted)
		btn.addTarget(self, action: "", forControlEvents: UIControlEvents.TouchUpInside)
		btn.hidden = true
		
		return btn
		
	}()
	
	
	// MARK: - Publick Method
	/** 显示 “开始体验” button   */
	func showStartButton(){
		
		starButton.hidden = false
		starButton.transform = CGAffineTransformMakeScale(0, 0)
		starButton.userInteractionEnabled = false
		
		UIView.animateWithDuration(0.5, animations: { () -> Void in
			self.starButton.transform = CGAffineTransformIdentity
			}) { (_) -> Void in
				self.starButton.userInteractionEnabled = true
		}
		
	}
	
	
	
}
