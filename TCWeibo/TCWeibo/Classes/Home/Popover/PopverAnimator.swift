//
//  PopverAnimator.swift
//  TCWeibo
//
//  Created by TailC on 16/5/25.
//  Copyright © 2016年 TailC. All rights reserved.
//

import UIKit

class PopverAnimator: NSObject , UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
	/// 展现位置
	var presentedFrame: CGRect = CGRectZero
	// 是否展现标记
	var isPresenting = false

	
	func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
		// 返回自定义展现控制器
		return PopoverPresentationController(presentedViewController: presented, presentingViewController: presenting)
	}
	
	///  指定负责 `展现` 转场动画的对象
	func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		isPresenting = true
		return self
	}
	
	///  指定负责 `消失` 转场动画的对象
	func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		isPresenting = false
		return self
	}
	
	///  转场动画时间
	func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
		return 0.5
	}
	
	///  自定义转场动画
	func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
		
		if isPresenting {
			let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
			transitionContext.containerView()!.addSubview(toView)
			toView.transform = CGAffineTransformMakeScale(1.0, 0)
			toView.layer.anchorPoint = CGPointMake(0.5, 0)
			
			UIView.animateWithDuration(transitionDuration(transitionContext),
				delay: 0,
				usingSpringWithDamping: 0.8,
				initialSpringVelocity: 5.0,
				options: UIViewAnimationOptions.LayoutSubviews,
				animations: {
					toView.transform = CGAffineTransformMakeScale(1.0, 1.0)
				}, completion: { (_) in
					toView.transform = CGAffineTransformIdentity
					transitionContext.completeTransition(true)
			})
		} else {
			let fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
			fromView.removeFromSuperview()
			transitionContext.completeTransition(true)
		}
		
	}
	
}

