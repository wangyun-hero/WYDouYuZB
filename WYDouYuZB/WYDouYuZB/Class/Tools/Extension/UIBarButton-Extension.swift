//
//  UIBarButton-Extension.swift
//  WYDouYuZB
//
//  Created by 王云 on 2020/3/22.
//  Copyright © 2020 王云. All rights reserved.
//

import UIKit
// 类扩展 功能和OC中分类一样
extension UIBarButtonItem {
    // 类方法
    class func creatItem(imageName:String,highImageName:String,size:CGSize) -> UIBarButtonItem{
        let btn = UIButton()
        btn.frame = CGRect(origin: CGPoint(), size: size)
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        return UIBarButtonItem(customView: btn)
    }
    
    /*
     苹果更建议我们去使用便利构造方法
     必须以 convenience 开头
     在构造函数中必须明确调用一个设计的构造函数（self）
     */
    convenience init(imageName:String,highImageName:String,size:CGSize) {
        let btn = UIButton()
        btn.frame = CGRect(origin: CGPoint(), size: size)
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        self.init(customView:btn)
    }
}
