//
//  Common.swift
//  WYDouYuZB
//
//  Created by 王云 on 2020/3/22.
//  Copyright © 2020 王云. All rights reserved.
//

import UIKit
// 类似OC中的宏定义

// 屏幕宽、高
let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height


// 判断是否是 iPhone
let kIsPhone = Bool(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)

// 判断是否是iPhoneX
let kIsPhoneX = Bool(kScreenW >= 375.0 && kScreenH >= 812.0 && kIsPhone)

// 导航条的高度
let kNavigationBarH = CGFloat(kIsPhoneX ? 88 : 64)

// 状态栏高度
let kStatusBarH = CGFloat(kIsPhoneX ? 44 : 20)

// tabbar高度
let kTabBarH = CGFloat(kIsPhoneX ? (49 + 34) : 49)

//顶部安全区域远离高度
let kTopSafeH = CGFloat(kIsPhoneX ? 44 : 0)

//底部安全区域远离高度
let kBottomSafeH = CGFloat(kIsPhoneX ? 34 : 0)
