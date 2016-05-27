//
//  NewFeatureViewController.swift
//  TCWeibo
//
//  Created by TailC on 16/5/27.
//  Copyright © 2016年 TailC. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class NewFeatureViewController: UICollectionViewController {

	let layout = UICollectionViewFlowLayout()
	
	let imageCount : Int = 4
	
	// MARK: - Life Cycle
	init(){
		super.init(collectionViewLayout: layout)
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.registerClass(NewFeatureCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		//设置布局
		layout.itemSize = view.bounds.size
		layout.minimumInteritemSpacing = 0
		layout.minimumLineSpacing = 0
		layout.scrollDirection = UICollectionViewScrollDirection.Horizontal
		
		self.collectionView?.pagingEnabled = true
		self.collectionView?.showsHorizontalScrollIndicator = false
		self.collectionView?.bounces = false
		
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	/** 隐藏状态栏  */
	override func prefersStatusBarHidden() -> Bool {
		return true
	}

}

extension NewFeatureViewController{
	
	override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
		// #warning Incomplete implementation, return the number of sections
		return 0
	}
	
	
	override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		// #warning Incomplete implementation, return the number of items
		return 0
	}
	
	override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
		
		// Configure the cell
		
		return cell
	}
	
	// 参数 cell, indexPath 是前一个 cell 和 indexPath
	override func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
		
		// 取出当前显示的 indexPath
		let indexPath = collectionView.indexPathsForVisibleItems().last!
		if indexPath.item == imageCount - 1 {
			
			let cell = collectionView.cellForItemAtIndexPath(indexPath) as! NewFeatureCell
			cell.showStartButton()
		}
	}
}
