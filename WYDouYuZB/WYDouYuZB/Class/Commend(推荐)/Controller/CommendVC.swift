//
//  CommendVC.swift
//  WYDouYuZB
//
//  Created by 王云 on 2020/3/22.
//  Copyright © 2020 王云. All rights reserved.
//

import UIKit
// 类似OC中的宏定义
private let kTitleViewH: CGFloat = 40

class CommendVC: UIViewController {
    // 标题titleView 懒加载属性 以闭包的形式
    private lazy var pageTitleView: PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView;
    }()
    
    // 内容pageContentView
    private lazy var pageContentView: PageContentView = {[weak self] in
        let pageContentViewFrameH = kScreenH - (kNavigationBarH + kTitleViewH + kTabBarH)
        let pageContentViewFrame = CGRect(x: 0, y: kNavigationBarH + kTitleViewH, width: kScreenW, height: pageContentViewFrameH)
        
        var childs = [TitleCommendVC]()
        
        for _ in 0..<4 {
            let vc = TitleCommendVC()
//            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childs.append(vc)
            
        }
        let pageContentView = PageContentView(frame: pageContentViewFrame, childVCs: childs, parentViewController: self)
        pageContentView.delegate = self
        return pageContentView
    }()
    
    // 系统的回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    } 
}

// 类扩展
// MARK: 设置UI界面
extension CommendVC {
    private func setupUI() {
        // 添加导航栏
        setupNavBar()
        // 添加titleView
        view.addSubview(pageTitleView)
        // 添加contenview
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
        
    }
    // 设置导航栏
    private func setupNavBar() {
        // 设置左边的logo
        let btn = UIButton()
        btn.setImage(UIImage(named: "logo"), for: .normal)
        btn.sizeToFit()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        // 设置右边按钮
        // 观看历史 便利构造器方式  苹果更建议用此种方式，而不是类方法
        // let historyItem = UIBarButtonItem.creatItem(imageName: "image_my_history", highImageName: "image_my_history_click", size: CGSize(width: 30, height: 30))
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: CGSize(width: 30, height: 30))
        // 游戏中心  类方法（不建议）
        let gameCenterItem = UIBarButtonItem.creatItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: CGSize(width: 30, height: 30))
        
        // 消息中心  类方法（不建议）
        let messageItem = UIBarButtonItem.creatItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: CGSize(width: 30, height: 30))
        
        self.navigationItem.rightBarButtonItems = [messageItem,gameCenterItem,historyItem]
        
    }
    
}

extension CommendVC: PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView,index: Int) {
        print(index)
        pageContentView.currentIndex(currentIndex: index)
    }
}

extension CommendVC: PageContentViewDelegate {
    func PageContentViewDelegate(pageContentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        pageTitleView.changeTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
