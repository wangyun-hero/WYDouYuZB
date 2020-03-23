//
//  PageContentView.swift
//  WYDouYuZB
//
//  Created by 王云 on 2020/3/23.
//  Copyright © 2020 王云. All rights reserved.
//

import UIKit
// 定义协议和方法传递滚动及相关参数
protocol PageContentViewDelegate: class {
    func PageContentViewDelegate(pageContentView: PageContentView,progress: CGFloat,sourceIndex: Int,targetIndex: Int)
}

private let contentCellID: String = "contentCellID"

class PageContentView: UIView {
    // 定义属性
    private var childVCs:[UIViewController]
    // 注意： weak 修饰的对象最后 必须加上 ？
    private weak var parentViewController: UIViewController?
    
    // 记录scrollview拖拽时候的offset
    private var startOffset: CGFloat = 0
    
    // 记录禁止执行代理
    private var isForbidScrollDelagate: Bool = false
    
    // 定义代理属性
    weak var delegate: PageContentViewDelegate?
    
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
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelagate = false
        startOffset = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // 判断是否是标题点击事件导致的滑动
        if isForbidScrollDelagate {
            return
        }
        
        // 获取数据
        var progress: CGFloat = 0.0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
        
        // 判断左滑或者右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollviewW = scrollView.bounds.size.width
        if currentOffsetX > startOffset { // 左滑
            
            //2.1 计算 progress
            progress = currentOffsetX / scrollviewW - floor(currentOffsetX / scrollviewW)
            
            //2.2 计算 sourceIndex
            sourceIndex = Int(currentOffsetX / scrollviewW)
            
            //2.3 计算 targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            
            //2.4 如果完全滑过去
            if currentOffsetX - startOffset == scrollviewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        } else { // 右滑
            
            //2.1 计算 progress
            progress = 1 - (currentOffsetX / scrollviewW - floor(currentOffsetX / scrollviewW))
            
            //2.2 计算 targetIndex
            targetIndex = Int(currentOffsetX / scrollviewW)
            
            //2.3 计算 sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }
            
        }
        
        // 将 progress targetIndex targetIndex 传递给titleView
        // 代理事件传递
        delegate?.PageContentViewDelegate(pageContentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
    
    
}

// 对外暴露的方法
extension PageContentView {
    // 从外界传入index进行处理
    func currentIndex(currentIndex:Int) -> (Void) {
        //  记录禁止执行代理
        isForbidScrollDelagate = true
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
