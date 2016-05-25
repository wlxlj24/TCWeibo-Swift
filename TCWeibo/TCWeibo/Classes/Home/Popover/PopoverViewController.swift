//
//  PopoverViewController.swift
//  TCWeibo
//
//  Created by TailC on 16/5/25.
//  Copyright © 2016年 TailC. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	// MARK: - UITableViewDelegate , UITableViewDataSource
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return friendGroup.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("PopupCell", forIndexPath: indexPath)
		cell.textLabel?.text = friendGroup[indexPath.row]
		return cell
	}
	
	
	// MARK: - Lazy
	/** 好友分组  */
	lazy var friendGroup : [String] = {
		return ["首页","好友圈","群微博","我的微博"]
	}()
	

}
