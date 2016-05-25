//
//  PopoverPresentationController.swift
//  TCWeibo
//
//  Created by TailC on 16/5/25.
//  Copyright © 2016年 TailC. All rights reserved.
//

import UIKit

class PopoverPresentationController: UIPresentationController {
	
	override init(presentedViewController: UIViewController, presentingViewController: UIViewController) {
		// presentedViewController 是要 Modal 展现的视图控制器
		super.init(presentedViewController: presentedViewController, presentingViewController: presentingViewController)
		
		// 准备遮罩视图
		prepareDummingView()
	}
	
	override func containerViewWillLayoutSubviews() {
		super.containerViewWillLayoutSubviews()
		presentedView()?.frame = CGRectMake(100, 56, 200, 300)
	}
	
	override func presentationTransitionWillBegin() {
		dummingView.frame = containerView!.bounds
		containerView?.insertSubview(dummingView, atIndex: 0)
	}
	
	
	private func prepareDummingView(){
		
	}
	
	/** Mask Veiw Tap Action  */
	func clickDummingView(){
		presentedViewController.dismissViewControllerAnimated(true, completion: nil)
	}
	
	/** 遮罩View  */
	lazy var dummingView: UIView = {
		let v = UIView()
		v.backgroundColor = UIColor(white: 0, alpha: 0.2)
		let tap = UITapGestureRecognizer(target: self, action: "clickDummingView")
		v.addGestureRecognizer(tap)
		return v
	}()
	
}
