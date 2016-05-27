//
//  MyQRCodeViewController.swift
//  TCWeibo
//
//  Created by TailC on 16/5/27.
//  Copyright © 2016年 TailC. All rights reserved.
//

import UIKit

class MyQRCodeViewController: UIViewController {

	/** 二维码 IV  */
	@IBOutlet weak var QRImageView: UIImageView!
	
	
	// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

		setupNav()
		setupQRView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	// MARK: - Setup
	/** 初始化 NavgitonBar  */
	private func setupNav(){
		title = "我的二维码"
	}
	
	/** 初始化二维码  */
	private func setupQRView(){
		QRImageView.image = generatoeQRCodeImage()
	}
	
	// MARK: - Private Method
	/** 生成二维码  */
	private func generatoeQRCodeImage() ->UIImage {
		//生成二维码
		let qrFilter = CIFilter(name: "CIQRCodeGenerator")
		qrFilter?.setDefaults()
		qrFilter?.setValue("区小施".dataUsingEncoding(NSUTF8StringEncoding), forKey: "inputMessage")
		let ciImage = qrFilter?.outputImage
		
		//缩放处理
		let transform = CGAffineTransformMakeScale(10, 10)
		let transformImage = ciImage?.imageByApplyingTransform(transform)
		
		//颜色滤镜
		let colorFilter = CIFilter(name: "CIFalseColor")
		colorFilter?.setDefaults()
		colorFilter?.setValue(transformImage, forKey: "inputImage")
		//前景色
		colorFilter?.setValue(CIColor(color: UIColor.blackColor()), forKey: "inputColor0")
		//背景色
		colorFilter?.setValue(CIColor(color: UIColor.whiteColor()), forKey: "inputColor1")
		
		let outputImage = colorFilter?.outputImage
		
		return insertAvatarImage(UIImage(CIImage: outputImage!), avatar: UIImage(named: "avatar_default")!)
		
	}
	
	/** 插入头像  */
	private func insertAvatarImage(qrimage:UIImage,avatar:UIImage) ->UIImage{
		
		UIGraphicsBeginImageContext(qrimage.size)
		
		let rect = CGRect(origin: CGPointZero, size: qrimage.size)
		qrimage.drawInRect(rect)
		
		let w = rect.width * 0.2
		let x = (rect.width - w) * 0.5
		let y = (rect.height - w) * 0.5
		avatar.drawInRect(CGRect(x: x, y: y, width: w, height: w))
		
		let image = UIGraphicsGetImageFromCurrentImageContext()
		
		UIGraphicsEndImageContext()
		
		return image
		
	}

}
