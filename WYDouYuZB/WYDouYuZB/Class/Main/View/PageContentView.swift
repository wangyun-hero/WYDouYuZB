//
//  PageContentView.swift
//  WYDouYuZB
//
//  Created by 王云 on 2020/3/23.
//  Copyright © 2020 王云. All rights reserved.
//

import UIKit

private let contentCellID: String = "contentCellID"

class PageContentView: UIView {
    // 定义属性
    private var childVCs:[UIViewController]
    // 注意： weak 修饰的对象最后 必须加上 ？
    private weak var parentViewController: UIViewController?
    
    // 懒加载属性CollectionView  在闭包里面使用self，要注意循环引用
    private lazy var collectionView: UICollectionView = {[weak self] in
        // 创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)! // 注意写法
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 创建CollectionView
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        return collectionView
    }()
    
    // 构造方法
    init(frame: CGRect,childVCs: [UIViewController],parentViewController: UIViewController?) {
        
        self.childVCs = childVCs
        self.parentViewController = parentViewController
        
        super.init(frame: frame)
        // 设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// 设置UI界面
extension PageContentView {
   private func setupUI() {
    // 添加自控制器
    for childVC in childVCs {
        parentViewController?.addChild(childVC)
    }
    
    // 添加CollectionView
    addSubview(collectionView)
    collectionView.frame = bounds
  }
}


// 遵守协议
extension PageContentView: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        
        // 先移除cell上所有内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        // 设置cell内容，将childVC的view添加到cell
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("我被点击了\(indexPath)")
    }
    
    
}

// 对外暴露的方法
extension PageContentView {
    // 从外界传入index进行处理
    func currentIndex(currentIndex:Int) -> (Void) {
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
