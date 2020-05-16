//
//  EmojiView.swift
//  EmojiKeyboard
//
//  Created by 彭豪辉 on 2020/5/16.
//  Copyright © 2020 彭豪辉. All rights reserved.
//

import UIKit

private let EmojiCellID = "EmojiCellID"

class EmojiView: UIView {

    @objc func itemClicked(item: UIBarButtonItem) {
        print(item.tag)
    }
    
    override init(frame: CGRect) {
        var rect = UIScreen.main.bounds
        rect.size.height = 320
        super.init(frame: rect)
        backgroundColor = .red
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 懒加载控件
    private lazy var emojiCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: EmojiLayout())
    private lazy var toolBar = UIToolbar()
    
    private class EmojiLayout: UICollectionViewFlowLayout, UICollectionViewDelegateFlowLayout {
        override func prepare() {
            super.prepare()
//            let col: CGFloat = 6
//            let row: CGFloat = 4
//
//            let w = collectionView!.bounds.width / col
//            print("w = \(w)")
//            print("width = \(collectionView!.bounds.width)")
//            let margin = (collectionView!.bounds.height - row * w) * 0.5
//            itemSize = CGSize(width: w, height: w)
            // collection view section 中，内部行间距
            minimumLineSpacing = 0
            // collection view section 中，每个 item 之间的间隔
            minimumInteritemSpacing = 0
            // collection view section 之间的间距
//            sectionInset = UIEdgeInsets(top: margin, left: 0, bottom: margin, right: 0)
            
            scrollDirection = .horizontal
            collectionView?.isPagingEnabled = true
            
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let col: CGFloat = 6
            
            let w = collectionView.bounds.width / col
            print("w = \(w)")
            print("width = \(collectionView.bounds.width)")
            
            return CGSize(width: w, height: w)
            
        }
        
    }
}

// MARK: - 设置界面
private extension EmojiView {
    func setupUI() {
        addSubview(emojiCollectionView)
        addSubview(toolBar)
        
        
        // 自动布局
        toolBar.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
            make.height.equalTo(44)
        }
        
        emojiCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top)
            make.bottom.equalTo(toolBar.snp.top)
            make.left.equalTo(self.snp.left)
            make.right.equalTo(self.snp.right)
        }
        
        prepareToolbar()
        prepareCollectionView()
    }
    
    func prepareToolbar() {
        // 创建按钮
        var items = [UIBarButtonItem]()
        
        var index = 0
        for s in ["最近", "默认", "emoji", "浪小花"] {
            items.append(UIBarButtonItem(title: s, style: .plain, target: self, action: #selector(itemClicked(item:))))
            items.last?.tag = index
            index += 1
            
            // 添加弹簧
            items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        }
        items.removeLast()
        
        toolBar.items = items
        toolBar.tintColor = .darkGray
    }
    
    func prepareCollectionView() {
        emojiCollectionView.backgroundColor = .lightGray
        emojiCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: EmojiCellID)
        emojiCollectionView.dataSource = self
    }
    
}

extension EmojiView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24 * 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCellID, for: indexPath)
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.green
        return cell
    }
}
