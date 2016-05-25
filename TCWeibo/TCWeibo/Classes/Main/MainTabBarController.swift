//
//  MainTabBarController.swift
//  TCWeibo
//
//  Created by TailC on 16/5/22.
//  Copyright © 2016年 TailC. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

		tabBar.tintColor = UIColor.orangeColor()
		
		setupViewControllers()
		

    }
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		//添加中间按钮
		setupCenterButton()
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
		
    }
	
	// MARK: - Private Method
	private func setupViewControllers(){
		
		// 1.获取json文件路径
		let jsonPath = NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil)
		// 2.加载json数据
		let jsonData = NSData(contentsOfFile: jsonPath!)
		
		// 3.序列化json
		do{
			// throw是Xcode7最明显的一个变化, Xcode7之前都是通过传入error指针捕获异常, Xocode7开始通过try/catch捕获异常
			let dictArr = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers)
			// 遍历字典时候需要明确指明数组中的数据类型
			for dict in dictArr as! [[String:String]]{
				// 由于addChildVC方法参数不能为nil, 但是字典中取出来的值可能是nil, 所以需要加上!
				addChildViewController(dict["vcName"]!, title: dict["title"]!, imageName: dict["imageName"]!)
			}
			
			
		}catch{
			addChildViewController("HomeTableViewController", title: "首页", imageName: "tabbar_home")
			addChildViewController("MessageTableViewController", title: "消息", imageName: "tabbar_message_center")
			//添加一个占位VC
			addChildViewController("NullViewController", title: "", imageName: "")
			addChildViewController("DiscoverTableViewController", title: "广场", imageName: "tabbar_discover")
			addChildViewController("ProfileTableViewController", title: "我", imageName: "tabbar_profile")
		}
	}
	
	/** 添加子控制器  */
	private func addChildViewController(childControllerName: String,title:String,imageName:String) {
		
		//获取NameSpace
		let nameSpace = NSBundle.mainBundle().infoDictionary!["CFBundleName"] as! String
		//将字符串转换成类
		let className : AnyClass = NSClassFromString(nameSpace + "." + childControllerName)!
		let vcClass = className as! UIViewController.Type
		let vc = vcClass.init()
		
		vc.tabBarItem.image = UIImage(named: imageName)
		vc.title = title
		vc.tabBarItem.selectedImage = UIImage(named: imageName+"_highlighted")
		
		let nav = UINavigationController(rootViewController: vc)
		addChildViewController(nav)
		
	}
	
	/** 初始化 “加号”按钮  */
	private func setupCenterButton(){
		tabBar.addSubview(centerButton)
		//计算button宽度
		let width = UIScreen.mainScreen().bounds.size.width / CGFloat((viewControllers?.count)!)
		//创建frame
		let frame = CGRect(x: 0, y: 0, width: width, height: 49)
		//设置按钮frame和偏移位
		centerButton.frame = CGRectOffset(frame, width * 2, 0)
	}
	
	// MARK: - Action
	func onClickCenterButton(){
		print(__FUNCTION__)
	}
	
	
	//MARK: - Lazy Load
	private lazy var centerButton:UIButton = {
		let button = UIButton()
		button.setImage(UIImage(named: "tabbar_compose_icon_add"), forState: UIControlState.Normal)
		button.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
		button.setBackgroundImage(UIImage(named: "tabbar_compose_button"), forState: UIControlState.Normal)
		button.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
		button.addTarget(self, action: "onClickCenterButton", forControlEvents: UIControlEvents.TouchUpInside)
		// Swift中能不写self就不写self, 在闭包中必须写self,懒加载是闭包
		self.tabBar.addSubview(button)
		return button
	}()

}
