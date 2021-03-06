//
//  HomeTableViewController.swift
//  TCWeibo
//
//  Created by TailC on 16/5/22.
//  Copyright © 2016年 TailC. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		if !userLogin
		{
			visitorView?.setupVisitorInfo(true, imageName: "visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜")
			return
		}
		
		setupNav()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
	
	
	
	let titleButton = TitleButton()
	
	// MARK: - Private Method
	private func setupNav(){
		navigationItem.leftBarButtonItem = UIBarButtonItem.createBarButtonItem("navigationbar_friendattention", target: self, action: "leftItemClick")
		navigationItem.rightBarButtonItem = UIBarButtonItem.createBarButtonItem("navigationbar_pop", target: self, action: "rightItemClick")
		
		titleButton.setTitle("毛小伟 ", forState: UIControlState.Normal)
		titleButton.addTarget(self, action: "titleBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
		navigationItem.titleView = titleButton
	
	}
	
	func scanQRCode(){
		let sb = UIStoryboard(name: "QRCode", bundle: nil).instantiateInitialViewController() as! UINavigationController
		presentViewController(sb, animated: true, completion: nil)
	}
	
	
	// MARK: - Action
	/** 导航栏 左按钮 点击事件  */
	func leftItemClick(){
		
	}
	
	/** 导航栏 右按钮 点击事件  */
	func rightItemClick(){
		scanQRCode()
	}
	
	///  转场动画代理
	let popoverAnimatorDelegate = PopverAnimator()
	
	/** 导航栏 中间按钮 点击事件  */
	func titleBtnClick(){
		
		UIView.animateWithDuration(0.5, animations: { () -> Void in
			self.titleButton.imageView!.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
			})
		
		if !userLogin{
			return
		}
		titleButton.selected = !titleButton.selected
		
		let sb = UIStoryboard(name: "PopoverViewController", bundle: nil)
		let popover = sb.instantiateViewControllerWithIdentifier("PopoverController") as! PopoverViewController
		// 设置转场动画代理
		popover.transitioningDelegate = popoverAnimatorDelegate
		// 设置 Modal 展现样式
		popover.modalPresentationStyle = UIModalPresentationStyle.Custom
		
		presentViewController(popover, animated: true, completion: nil)
		
	}
	
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



