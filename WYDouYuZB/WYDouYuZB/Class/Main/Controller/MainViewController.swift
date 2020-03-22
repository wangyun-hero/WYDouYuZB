//
//  MainViewController.swift
//  WYDouYuZB
//
//  Created by 王云 on 2020/3/22.
//  Copyright © 2020 王云. All rights reserved.
//

import UIKit
class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 通过storyboard获取对应的控制器
        addChildVC(storyName: "Commend")
        addChildVC(storyName: "Play")
        addChildVC(storyName: "Follow")
        addChildVC(storyName: "Community")
        addChildVC(storyName: "Discover")
        // Do any additional setup after loading the view.
    }
    
    private func addChildVC(storyName : String){
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        addChild(childVC)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
