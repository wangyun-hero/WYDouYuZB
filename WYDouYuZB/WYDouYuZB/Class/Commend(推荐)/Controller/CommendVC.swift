//
//  CommendVC.swift
//  WYDouYuZB
//
//  Created by 王云 on 2020/3/22.
//  Copyright © 2020 王云. All rights reserved.
//

import UIKit

class CommendVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
  

}

// MARK: 设置UI界面
extension CommendVC {
    private func setupUI() {
        
        setupNavBar()
        
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
//        let historyItem = UIBarButtonItem.creatItem(imageName: "image_my_history", highImageName: "image_my_history_click", size: CGSize(width: 30, height: 30))
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: CGSize(width: 30, height: 30))
        // 游戏中心  类方法（不建议）
        let gameCenterItem = UIBarButtonItem.creatItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: CGSize(width: 30, height: 30))
        
        // 消息中心  类方法（不建议）
        let messageItem = UIBarButtonItem.creatItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: CGSize(width: 30, height: 30))
        
        self.navigationItem.rightBarButtonItems = [messageItem,gameCenterItem,historyItem]
        
    }
    
}
