//
//  QRCodeViewController.swift
//  TCWeibo
//
//  Created by TailC on 16/5/25.
//  Copyright © 2016年 TailC. All rights reserved.
//

import UIKit
import AVFoundation

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
		setupSession()
		setupLayer()
		startScan()
		
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

	
	// MARK: - Setup
	/** 初始化会话  */
	private func setupSession(){
		
		if !session.canAddInput(inputDevice){
			return
		}
		if !session.canAddOutput(outputData){
			return
		}
		
		// 3. 添加设备
		session.addInput(inputDevice)
		session.addOutput(outputData)
		print(outputData.availableMetadataObjectTypes)
		
		// 4. 设置扫描数据类型
		outputData.metadataObjectTypes = outputData.availableMetadataObjectTypes
		// 5. 设置输出代理
		outputData.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
		
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
	
	/** 开始扫描  */
	private func startScan(){
		session.startRunning()
	}
	
	/** 设置图层  */
	private func setupLayer(){

		drawLayer.frame = view.bounds
		view.layer.insertSublayer(drawLayer, atIndex: 0)
		
		previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
		previewLayer.frame = view.bounds
		view.layer.insertSublayer(previewLayer, atIndex: 0)

	}
	
	/** 绘制条码形状  */
	private func drawCornerShape(dataObject:AVMetadataMachineReadableCodeObject){
		
		if dataObject.corners.isEmpty {
			return
		}
		
		let layer = CAShapeLayer()
		layer.lineWidth = 4
		layer.strokeColor = UIColor.orangeColor().CGColor
		layer.fillColor = UIColor.clearColor().CGColor
		layer.path = cornersPath(dataObject.corners)
		
		drawLayer.addSublayer(layer)
		
	}
	
	private func cornersPath(corners:NSArray) ->CGPathRef {
		
		let path = UIBezierPath()
		var point = CGPoint()
		
		// 1. 移动到第一个点
		var index = 0
		CGPointMakeWithDictionaryRepresentation((corners[index++] as! CFDictionaryRef), &point)
		path.moveToPoint(point)
		
		// 2. 遍历剩余的点
		while index < corners.count {
			CGPointMakeWithDictionaryRepresentation((corners[index++] as! CFDictionaryRef), &point)
			path.addLineToPoint(point)
		}
		
		// 3. 关闭路径
		path.closePath()
		
		return path.CGPath
		
	}
	
	/** 清空绘图图层  */
	private func clearDrawLayer() {
		if drawLayer.sublayers == nil {
			return
		}
		
		for layer in drawLayer.sublayers! {
			layer.removeFromSuperlayer()
		}
	}
	
	// MARK: - Lazy
	/** 拍摄会话  */
	lazy var session : AVCaptureSession = {
		return AVCaptureSession()
	}()
	
	/** 输入设备  */
	lazy var inputDevice : AVCaptureDeviceInput? = {
		let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
		do {
			return try AVCaptureDeviceInput(device: device)
		}catch{
			print(error)
			return nil
		}
	}()
	
	/** 数据输出  */
	lazy var outputData:AVCaptureMetadataOutput = {
		return AVCaptureMetadataOutput()
	}()
	
	/** 预览图层  */
	lazy var previewLayer: AVCaptureVideoPreviewLayer = {
		return AVCaptureVideoPreviewLayer(session: self.session)
	}()
	
	/** 绘制边框图层  */
	lazy var drawLayer: CALayer = {
		
		let layer = CALayer()
		return layer
	}()
	
}

extension QRCodeViewController:AVCaptureMetadataOutputObjectsDelegate{
	// MARK: - 扫描数据代理
	func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
		
		clearDrawLayer()
		
		for object in metadataObjects {
			let dataObject = previewLayer.transformedMetadataObjectForMetadataObject(object as! AVMetadataObject) as! AVMetadataMachineReadableCodeObject
			drawCornerShape(dataObject)
		}
	}
}


extension QRCodeViewController:UITabBarDelegate{
	
	func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
		captureViewHeight.constant = captureViewWidth.constant * (item.tag == 1 ? 0.5 : 1)
	}
	
}
