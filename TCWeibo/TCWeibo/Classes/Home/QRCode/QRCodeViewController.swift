//
//  QRCodeViewController.swift
//  TCWeibo
//
//  Created by TailC on 16/5/25.
//  Copyright © 2016年 TailC. All rights reserved.
//

import UIKit

class QRCodeViewController: UIViewController {

	@IBOutlet weak var tabBar: UITabBar!
	/** 冲击波IV  */
	@IBOutlet weak var animationIV: UIImageView!
	@IBOutlet weak var animationIVTop: NSLayoutConstraint!
	
	/** 二维码扫描区 高度约束  */
	@IBOutlet weak var captureViewHeight: NSLayoutConstraint!
	/** 二维码扫描区 宽度约束  */
	@IBOutlet weak var captureViewWidth: NSLayoutConstraint!
	
	
	// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
		
		//默认选中第一个
		tabBar.selectedItem = tabBar.items!.first;
		//开始动画
		scanAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	
	// MARK: - Action
	/** 导航栏左键 "关闭" button  */
	@IBAction func onClickNavLeftButton(sender: AnyObject) {
		dismissViewControllerAnimated(true, completion: nil)
	}
	
	/** 导航栏右键 相册 button  */
	@IBAction func onClickNavRightButton(sender: AnyObject) {
		
	}

	
	// MARK: - Private Method
	/** 冲击波动画  */
	private func scanAnimation(){
		
		// 停止图层动画
		animationIV.layer.removeAllAnimations()
		animationIVTop.constant = -captureViewHeight.constant
		view.layoutIfNeeded()
		
		UIView.animateWithDuration(2.0) { () -> Void in
			self.animationIVTop.constant = self.captureViewHeight.constant
			UIView.setAnimationRepeatCount(MAXFLOAT)
			self.view.layoutIfNeeded()
		}
		
	}
	
}

extension QRCodeViewController:UITabBarDelegate{
	
	func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
		captureViewHeight.constant = captureViewWidth.constant * (item.tag == 1 ? 0.5 : 1)
	}
	
}
