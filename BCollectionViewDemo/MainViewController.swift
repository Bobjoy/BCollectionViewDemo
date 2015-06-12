//
//  MainViewController.swift
//  Vetrip
//
//  Created by Vetech on 15/5/21.
//  Copyright (c) 2015年 Vetech. All rights reserved.
//

import Foundation
import UIKit


struct BGColor {
    static let red = "#FF697A"
    static let blue = "#3D98FF"
    static let green = "#5EBE00"
    static let orange = "#FC9720"
    
    static let barColor = "#099FDE"
}

class MainViewController: UIViewController ,UICollectionViewDataSource,UICollectionViewDelegate {

    @IBOutlet weak var pic: UIView!
    var collectionView: UICollectionView!
    let identifier : String = "VetripCollectionCell"
    var dataList = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "首页"
        self.navigationController?.navigationBarHidden = true
        
        dataList = [
            ["hotel.png","酒店","海外","周边","团购・特惠","客栈・公寓",BGColor.red],
            ["flight.png","机票","火车票","接送机","汽车票","自驾・专车",BGColor.blue],
            ["travel.png","旅游","门票・玩乐","出境WiFi","邮轮","签证",BGColor.green],
            ["gonglue.png","攻略","周末游","礼品卡","美食・购物","更多",BGColor.orange]
        ]
        
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical;//布局方向
        layout.minimumLineSpacing = 5;//行间距
        layout.minimumInteritemSpacing = 5;//列间距
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//上,左,下,右边界范围
        
        let itemWidth = self.view.frame.width-20
        let count = self.dataList.count | 1
        let itemHeight = (self.view.frame.height-120)/CGFloat(count)
        layout.itemSize = CGSizeMake(itemWidth, itemHeight);
        
        collectionView = UICollectionView(frame: CGRectMake(0.0, 100.0, self.view.frame.width, self.view.frame.height-150), collectionViewLayout:layout);
        //注册Cell
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.dataSource = self;
        collectionView.delegate = self;
        
        collectionView.setTranslatesAutoresizingMaskIntoConstraints(false)
        pic.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.view.addSubview(collectionView)
        
        let views = ["head": pic, "collectionView": collectionView]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[head]|", options: nil, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[collectionView]|", options: nil, metrics: nil, views: views))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-160-[collectionView]-50-|", options: nil, metrics: nil, views: views))
        
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataList.count;
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let nibName = UINib(nibName: "BCollectionViewCell", bundle: nil)
        collectionView.registerNib(nibName, forCellWithReuseIdentifier: identifier)
        
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath) as! BCollectionViewCell
        
        var data = self.dataList[indexPath.row]
        cell.initCell(indexPath.row, data: data) {self.gotoNextView($0)}
        return cell;
    }
    
    override func sizeForChildContentContainer(container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSizeMake(60, 60)
    }
    
    func gotoNextView(sender: AnyObject) {
        if let tap = sender as? UITapGestureRecognizer {
            if let label = tap.view as? UILabel where label.isKindOfClass(UILabel.self) {
                UIAlertView(title: "提示", message: "\(label.text!)", delegate: self, cancelButtonTitle: "确定").show()
            }
        }
    }
}
