//
//  BaseTableViewController.swift
//  TCWeibo
//
//  Created by TailC on 16/5/23.
//  Copyright © 2016年 TailC. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController , VisitorViewDelegate {

	var userLogin = true
	
	//访客登陆视图
	var visitorView : VisitorLoginView?
	
    override func viewDidLoad() {
        super.viewDidLoad()

        userLogin ? super.viewDidLoad() : setupVistorView()
    }
	
	
	/**
	初始化访客页面
	*/
	private func setupVistorView(){
		visitorView = VisitorLoginView()
		visitorView?.delegate = self
		view = visitorView
		
		// 添加导航栏按钮
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItemStyle.Plain, target: self, action: "")
		navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登陆", style: UIBarButtonItemStyle.Plain, target: self, action: "")
		
	}
	
	// MARK: - VisitorViewDelegate
	func registerBtnWillClick() {
		
	}
	
	func loginBtnWillClick() {
		
	}

}
