//
//  PageTitleView.swift
//  WYDouYuZB
//
//  Created by 王云 on 2020/3/22.
//  Copyright © 2020 王云. All rights reserved.
//

// 首页顶部 标题titleView
import UIKit

/*
 通过代理通知外界点击了lable
 class 表示只能被类遵守
 */
protocol PageTitleViewDelegate: class{
    func pageTitleView(titleView: PageTitleView,index: Int)
}



private let kScrollViewLineH: CGFloat = 2.0

// 使用了元祖
private let kNormalColor:(CGFloat,CGFloat,CGFloat) = (85,85,85)
private let kselectColor:(CGFloat,CGFloat,CGFloat) = (255,120,0)

class PageTitleView: UIView {

    // 定义属性
    // 记录上一个label 的 index
    private var currentIndex: Int = 0
    
    // 记录标题
    private var titles: [String]
    
    // 代理属性
    weak var delegate: PageTitleViewDelegate?
    
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
    init(frame: CGRect, titles: [String]) {
        
        self.titles = titles
        
        super.init(frame: frame)
        
        // 设置 UI 界面
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
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center
            // 设置label的frame
            
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            // 添加label
            scrollView.addSubview(label)
            titleLabels.append(label)
            
            // 处理交互 给label添加手势
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(labelCilck(tapGes:)))
            label.addGestureRecognizer(tapGes)
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
        firstLabel.textColor = UIColor(r: kselectColor.0, g: kselectColor.1, b: kselectColor.2)
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollViewLineH, width: firstLabel.frame.width, height: kScrollViewLineH)
    }
}


// 按钮手势监听
extension PageTitleView {
    /*
     @objc 自定义点击事件必须写
     tapGes.view as? UILabel 转为UILabel
     */
    @objc private func labelCilck(tapGes: UITapGestureRecognizer) {
        print("label被点击了")
        // 获取当前label的下标
        guard let currentLabel = tapGes.view as? UILabel else { return  }
        // 获取上一个点击的label
        let oldLabel = titleLabels[currentIndex]
        // 将现在点击的index进行记录
        currentIndex = currentLabel.tag
        // 获取上一个点击label的index
        currentLabel.textColor = UIColor(r: kselectColor.0, g: kselectColor.1, b: kselectColor.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        // 滚动条位置变化
        let scrollLinePositionX = CGFloat(currentLabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLinePositionX
        }
        
        // 通知代理
        delegate?.pageTitleView(titleView: self, index: currentIndex)
    }
}

// 暴露给外界的方法用于在控制器对label进行设置
extension PageTitleView {
    func changeTitleWithProgress(progress: CGFloat,sourceIndex: Int,targetIndex: Int) -> (Void) {
        // 取出source和target  label
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 颜色渐变
        // 1 获取变化的范围
        let colorRang = (kselectColor.0 - kNormalColor.0,kselectColor.1 - kNormalColor.1,kselectColor.2 - kNormalColor.2)
        // 变化sourceLabel
        sourceLabel.textColor = UIColor(r: kselectColor.0 - colorRang.0 * progress, g: kselectColor.1 - colorRang.1 * progress, b: kselectColor.2 - colorRang.2 * progress)
        // 变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorRang.0 * progress, g: kNormalColor.1 + colorRang.1 * progress, b: kNormalColor.2 + colorRang.2 * progress)
        
        // 记录新的index
        currentIndex = targetIndex
        
    }
}
