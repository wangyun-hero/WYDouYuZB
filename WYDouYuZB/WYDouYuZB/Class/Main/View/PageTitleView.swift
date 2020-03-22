//
//  PageTitleView.swift
//  WYDouYuZB
//
//  Created by 王云 on 2020/3/22.
//  Copyright © 2020 王云. All rights reserved.
//

import UIKit
private let kScrollViewLineH: CGFloat = 2.0
class PageTitleView: UIView {

    // 定义属性
    private var titles: [String]
    // 懒加载数组，记录labels
    private lazy var titleLabels: [UILabel] = [UILabel]()
    // 懒加载Scrollview
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    // 懒加载滚动条
    private lazy var scrollLine: UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    // 自定义构造函数
    init(frame: CGRect,titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        // 设置UI
        setupUI()
        
        
    }
    
    // 自定义构造函数时候跟着必写
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// 类扩展 设置UI
extension PageTitleView {
    private func setupUI() {
        // 添加UIScrollview
        addSubview(scrollView)
        scrollView.frame = bounds;
        
        // 添加label
        setupTitleLabes()
        
        // 设置底线和滚动条
        setupBottomLine()
    }
    
    // 用于设置label
    private func setupTitleLabes() {
        
        // 不需要重复计算放在外面
        let labelW: CGFloat = frame.width / CGFloat(titles.count) // 强转类型
        let labelH: CGFloat = frame.height - kScrollViewLineH
        let labelY: CGFloat = 0
        
        // 这样可以获取下标和标题
        for (index,title) in titles.enumerated() {
            // 创建label
            let label = UILabel()
            // 设置label属性
            label.text = title;
            label.tag = index;
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.darkGray
            label.textAlignment = .center
            // 设置label的frame
            
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 添加label
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
    }
    
    
    private func setupBottomLine() {
        // 添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH: CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        // 添加滚动条
        // 获取第一个label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor.orange
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollViewLineH, width: firstLabel.frame.width, height: kScrollViewLineH)
    }
}
