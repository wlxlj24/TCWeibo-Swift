//
//  VisitorLoginView.swift
//  TCWeibo
//
//  Created by TailC on 16/5/24.
//  Copyright © 2016年 TailC. All rights reserved.
//

import UIKit
import SnapKit

protocol VisitorViewDelegate: NSObjectProtocol{
	// 登录回调
	func loginBtnWillClick()
	// 注册回调
	func registerBtnWillClick()
}



class VisitorLoginView: UIView {

	weak var delegate : VisitorViewDelegate?
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupUI()
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
	func startAnimation(){
		let animation = CABasicAnimation(keyPath: "transform.rotation")
		animation.toValue = 2 * M_PI
		animation.repeatCount = MAXFLOAT
		animation.duration = 20.0
		animation.removedOnCompletion = false
		
		iconView.layer.addAnimation(animation, forKey: nil)
	}
	
	func setupVisitorInfo(isHome:Bool,imageName:String,message:String){
		iconView.hidden = !isHome
		messageLabel.text = message
		homeIconView.image = UIImage(named:imageName)
		
		if isHome {
			startAnimation()
		}
	}
	
	private func setupUI(){
		//添加控件
		addSubview(iconView)
		addSubview(maskIconView)
		addSubview(homeIconView)
		addSubview(messageLabel)
		addSubview(registerButton)
		addSubview(loginButton)
		
		backgroundColor = UIColor(white: 237.0/255.0, alpha: 1.0)
		
		//设置布局
		iconView.snp_makeConstraints { (make) -> Void in
			make.center.equalTo(self)
		}
		homeIconView.snp_makeConstraints { (make) -> Void in
			make.center.equalTo(self)
		}
		messageLabel.snp_makeConstraints { (make) -> Void in
			make.centerX.equalTo(iconView)
			make.bottom.equalTo(homeIconView).offset(60)
			make.left.equalTo(self.snp_left).offset(50)
			make.right.equalTo(self.snp_right).offset(-50)
		}
		registerButton.snp_makeConstraints { (make) -> Void in
			make.width.equalTo(100)
			make.height.equalTo(35)
			make.right.equalTo(self.snp_centerX).offset(-10)
			make.top.equalTo(messageLabel.snp_bottom).offset(20)
		}
		loginButton.snp_makeConstraints { (make) -> Void in
			make.width.equalTo(registerButton)
			make.height.equalTo(registerButton)
			make.centerY.equalTo(registerButton)
			make.left.equalTo(self.snp_centerX).offset(10)
		}
		maskIconView.snp_makeConstraints { (make) -> Void in
			make.left.equalTo(self.snp_left)
			make.right.equalTo(self.snp_right)
			make.bottom.equalTo(self.snp_bottom)
			make.top.equalTo(self.snp_top)
		}
	}
	
	//MARK: - 界面元素懒加载
	/// 背景图标
	private lazy var iconView: UIImageView = {
		let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
		return iv
	}()
	
	/// 小房子
	private lazy var homeIconView: UIImageView = {
		let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
		return iv
	}()
	
	/// 消息文字
	private lazy var messageLabel: UILabel = {
		let label = UILabel()
		label.text = "关注一些人，回这里看看有什么惊喜"
		label.textColor = UIColor.darkGrayColor()
		label.font = UIFont.systemFontOfSize(14)
		label.textAlignment = NSTextAlignment.Center
		label.numberOfLines = 0
		label.sizeToFit()
		return label
	}()
	
	/// 注册按钮
	private lazy var registerButton: UIButton = {
		let btn = UIButton()
		btn.setTitle("注册", forState: UIControlState.Normal)
		btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
		btn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
		btn.addTarget(self, action: "onClickRegisterButton", forControlEvents: UIControlEvents.TouchUpInside)
		return btn
	}()
	
	/// 登录按钮
	private lazy var loginButton: UIButton = {
		let btn = UIButton()
		btn.setTitle("登录", forState: UIControlState.Normal)
		btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), forState: UIControlState.Normal)
		btn.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
		btn.addTarget(self, action: "onCLlickLoginButton", forControlEvents: UIControlEvents.TouchUpInside)
		return btn
	}()
	
	/// 遮罩图片
	// 注意系统有一个叫做maskView的属性, 属性名称不能叫做maskView
	private lazy var maskIconView: UIImageView = {
		let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_mask_smallicon"))
		return iv
	}()
	
	// MARK: - Action
	func onClickRegisterButton(){
		delegate?.registerBtnWillClick()
	}
	
	func onCLlickLoginButton(){
		delegate?.loginBtnWillClick()
	}

}
